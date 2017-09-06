//
//  PaginationManager.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 06/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit

protocol PaginationManagerDelegate: class {
	
	func refreshAll(completion: @escaping (_ hasMoreData: Bool) -> Void)
	
	func loadMore(completion: @escaping (_ hasMoreData: Bool) -> Void)
}

class PaginationManager: NSObject {
	
	fileprivate weak var scrollView: UIScrollView?
	
	fileprivate var refreshControl: UIRefreshControl?
	fileprivate var bottomLoader: UIView?
	
	var delegate: PaginationManagerDelegate?
	
	fileprivate var isObservingKeypath = false
	
	var showPullToRefresh: Bool {
		didSet {
			self.setupPullToRefresh()
		}
	}
	
	var isLoading: Bool = false
	var hasMoreDataToLoad: Bool = true
	
	init(scrollView: UIScrollView, showPullToRefresh: Bool = true) {
		self.scrollView = scrollView
		self.showPullToRefresh = showPullToRefresh
		super.init()
		self.setupPullToRefresh()
	}
	
	deinit {
		self.removeScrollViewOffsetObserver()
	}
	
	func load(completion: @escaping () -> Void) {
		self.refresh {
			completion()
		}
	}
	func someThing() {
		
	}
	
}

extension PaginationManager {
	
	fileprivate func setupPullToRefresh() {
		if self.showPullToRefresh {
			self.addRefreshControl()
		} else {
			self.removeRefreshControl()
		}
	}
	
	fileprivate func addRefreshControl() {
		self.refreshControl = UIRefreshControl()
		self.scrollView?.addSubview(self.refreshControl!)
		self.refreshControl?.addTarget(
			self,
			action: #selector(PaginationManager.handleRefresh),
			for: .valueChanged
		)
	}
	
	fileprivate func removeRefreshControl() {
		self.refreshControl?.removeTarget(
			self,
			action: #selector(PaginationManager.handleRefresh),
			for: .valueChanged
		)
		self.refreshControl?.removeFromSuperview()
		self.refreshControl = nil
	}
	
	@objc fileprivate func handleRefresh() {
		// Do Refresh
		if self.isLoading {
			self.refreshControl?.endRefreshing()
			return
		}
		self.isLoading = true
		self.delegate?.refreshAll { [weak self] hasMoreData in
			self?.isLoading = false
			self?.hasMoreDataToLoad = hasMoreData
			self?.refreshControl?.endRefreshing()
		}
		
	}
	
	fileprivate func refresh(completion: @escaping () -> Void) {
		// Do Refresh
		if self.isLoading {
			self.refreshControl?.endRefreshing()
			return
		}
		self.isLoading = true
		self.delegate?.refreshAll { [weak self] hasMoreData in
			self?.isLoading = false
			self?.hasMoreDataToLoad = hasMoreData
			if hasMoreData {
				self?.addScrollViewOffsetObserver()
				self?.addBottomLoader()
			}
			self?.refreshControl?.endRefreshing()
			completion()
		}
	}
	
}


extension PaginationManager {
	
	fileprivate func addBottomLoader() {
		guard let scrollView = self.scrollView else { return }
		let view = UIView()
		view.frame.size.height = 60
		view.frame.size.width = scrollView.frame.width
		view.frame.origin.y = scrollView.contentSize.height
		view.frame.origin.x = 0
		view.backgroundColor = UIColor.clear
		let activity = UIActivityIndicatorView(activityIndicatorStyle: .gray)
		activity.frame = view.bounds
		activity.startAnimating()
		view.addSubview(activity)
		self.bottomLoader = view
		scrollView.contentInset.bottom = view.frame.height
	}
	
	fileprivate func showBottomLoader() {
		guard let scrollView = self.scrollView, let loader = self.bottomLoader else { return }
		scrollView.addSubview(loader)
	}
	
	fileprivate func hideBottomLoader() {
		self.bottomLoader?.removeFromSuperview()
	}
	
	fileprivate func removeBottomLoader() {
		self.bottomLoader?.removeFromSuperview()
		self.scrollView?.contentInset.bottom = 0
	}
	
	func addScrollViewOffsetObserver() {
		if self.isObservingKeypath { return }
		self.scrollView?.addObserver(
			self,
			forKeyPath: "contentOffset",
			options: [.new],
			context: nil
		)
		self.isObservingKeypath = true
	}
	
	func removeScrollViewOffsetObserver() {
		if self.isObservingKeypath {
			self.scrollView?.removeObserver(self, forKeyPath: "contentOffset")
		}
		self.isObservingKeypath = false
	}
	
	override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
		guard let object = object as? UIScrollView, let keyPath = keyPath, let newValue = change?[.newKey] as? CGPoint else { return }
		if object == self.scrollView && keyPath == "contentOffset" {
			self.setContentOffSet(newValue)
		}
	}
	
	func setContentOffSet(_ offset: CGPoint) {
		guard let scrollView = self.scrollView else { return }
		self.bottomLoader?.frame.origin.y = scrollView.contentSize.height
		if !scrollView.isDragging && !scrollView.isDecelerating { return }
		if self.isLoading || !self.hasMoreDataToLoad { return }
		let offsetY = offset.y
		if offsetY >= scrollView.contentSize.height - scrollView.frame.size.height {
			self.isLoading = true
			self.showBottomLoader()
			self.delegate?.loadMore { [weak self] hasMoreData in
				self?.hideBottomLoader()
				self?.isLoading = false
				self?.hasMoreDataToLoad = hasMoreData
				if !hasMoreData {
					self?.removeBottomLoader()
					self?.removeScrollViewOffsetObserver()
				}
			}
		}
	}
	
}
