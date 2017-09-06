//
//  CSAFF.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 06/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient

public protocol Routable: JSONParseable {
	static func router(page: Int, pageSize: Int) -> Router
//	static func fetch (page: Int, pageSize: Int, completion: @escaping APICompletion<ListResponse<Self>>)
	static func fetch (page: Int, pageSize: Int, completion: @escaping APICompletion<EventResponse>)
}

extension Routable {
	public static func fetch(page:Int, pageSize: Int, completion: @escaping APICompletion<EventResponse>) {
		let router = self.router(page: page, pageSize: pageSize)
		CSAFFAPIClient.shared.request(router: router, completion: completion)
	}

//	public static func fetch(page:Int, pageSize: Int, completion: @escaping APICompletion<ListResponse<Self>>) {
//		let router = self.router(page: page, pageSize: pageSize)
//		CSAFFAPIClient.shared.request(router: router, completion: completion)
//	}
}

final public class Paginator<T:Routable> {
//	public var items: [T] = []
	public var items: [Event] = []
	public var currentPage: Int
	public var canLoadMore: Bool = true
	
	let pageSize = 20
	
	public init() {
		self.currentPage = 0
	}
	
//	public func loadNextPage(completion: @escaping APICompletion<[T]>) {
//		T.fetch(page: self.currentPage, pageSize: self.pageSize) { [weak self] (result: APIResult<ListResponse<T>>) in
//			guard let this = self else { return }
//			switch result {
//			case .success( let items):
//				print(items.list.count)
//				for item in items.list {
//					this.items.append(item)
//				}
//				this.canLoadMore = items.list.count >= this.pageSize
//				if this.canLoadMore {
//					this.currentPage += 1
//				}
//				completion(.success(items.list))
//			case .failure(let error):
//				completion(.failure(error))
//			}
//		}
//	}
	
//	public func refresh(completion: @escaping APICompletion<[T]>) {
//		self.currentPage = 0
//		self.items.removeAll()
//		self.loadNextPage(completion: completion)
//	}

	
	public func loadNextPage(completion: @escaping APICompletion<EventResponse>) {
		T.fetch(page: self.currentPage, pageSize: self.pageSize) { [weak self] (result: APIResult<EventResponse>) in
			guard let this = self else { return }
			switch result {
			case .success(let events):
				this.canLoadMore = events.events.count >= this.pageSize
				if this.canLoadMore {
					this.currentPage += 1
				}
				for item in events.events {
					this.items.append(item)
				}
				completion(.success(events))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}

	public func refresh(completion: @escaping APICompletion<EventResponse>) {
		self.currentPage = 0
		self.items.removeAll()
		self.loadNextPage(completion: completion)
	}
}

extension Event: Routable {
	public static func router(page: Int, pageSize: Int) -> Router {
		return APIRouter.fetchEvents
	}
}
