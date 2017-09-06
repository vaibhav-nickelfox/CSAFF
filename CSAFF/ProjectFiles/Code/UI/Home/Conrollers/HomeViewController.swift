//
//  HomeViewController.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 01/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit
import Paginator

class HomeViewController: UIViewController {

	@IBOutlet var tableView: UITableView!
	var paginationManager: PaginationManager?
	fileprivate let paginator = Paginator<Event>()
	var loaderView: UIView?
	
	var cellItems: [HomeCellModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
		configureNavbar()
		setupTableView()
		setupPagination()
		fetchEvents()
	}
	
	func fetchEvents() {
		self.showLoader()
		self.paginationManager?.load { [weak self] _ in
			self?.hideLoader()
		}

	}
	
	fileprivate func setupPagination() {
		customRefreshView()
		self.paginationManager = PaginationManager(scrollView: self.tableView, showPullToRefresh: true, refreshView: self.loaderView)
		self.paginationManager?.delegate = self
	}
	
	fileprivate func handleDataLoad(events: [Event]?) {
		if let events = events {
			self.cellItems = events.map {
				HomeCellModel(image: $0.imageURL, title: $0.name)
			}
		} else {
			self.cellItems = []
		}
		tableView.reloadData()
	}
	
	fileprivate func handleMoreDataLoad(events: [Event]?) {
		if let events = events {
			self.cellItems = events.map {
				HomeCellModel(image: $0.imageURL, title: $0.name)
			}
			tableView.reloadData()
		}
	}
	
	fileprivate func configureNavbar() {
		self.navigationController?.navigationBar.barTintColor = UIColor(hexString: "B53F5E")
		self.navigationController?.navigationBar.isTranslucent = false
		UIApplication.shared.statusBarStyle = .lightContent
	}
	
	@IBAction func handleCityTaped(_ sender: UIButton) {
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.destination is SelectCityViewController {
			let vc = segue.destination as! SelectCityViewController
			vc.delegate = self
		}
	}
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
	fileprivate func setupTableView() {
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return cellItems.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableCell.identifier, for: indexPath) as! HomeTableCell
		cell.item = cellItems[indexPath.row]
		return cell
	}
}

extension HomeViewController: SelectCityDelegate {
	func didSelectCity(_ viewController: SelectCityViewController, _ model: CityModel) {
		print(model.city)
	}
}

//MARK: Pagination Manager Delegate
extension HomeViewController: PaginationManagerDelegate {
	func refreshAll(completion: @escaping (Bool) -> Void) {
		self.paginator.refresh { [weak self](eventList) in
			guard let this = self else { return }
			this.handleDataLoad(events: eventList.value?.events)
			//this.handleDataLoad(events: eventList.value)
			completion(this.paginator.canLoadMore)
		}
	}
	
	func loadMore(completion: @escaping (Bool) -> Void) {
		self.paginator.loadNextPage { [weak self](eventList) in
			guard let this = self else { return }
			this.handleMoreDataLoad(events: eventList.value?.events)
//			this.handleMoreDataLoad(events: eventList.value)
			completion(this.paginator.canLoadMore)
		}
	}
}

//MARK: Refresh Animation
extension HomeViewController {
	fileprivate func customRefreshView() {
		let refreshContent = Bundle.main.loadNibNamed("RefreshView", owner: self, options: nil)
		self.loaderView = (refreshContent?[0] as! UIView)
	}
}
