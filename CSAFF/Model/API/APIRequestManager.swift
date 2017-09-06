//
//  APIRequestManager.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import UIKit
import  APIClient

class APIRequestManager: NSObject {

	static func fetch(completion: @escaping APICompletion<EventResponse>) {
		CSAFFAPIClient.shared.request(router: APIRouter.fetchEvents) { (result: APIResult<EventResponse>) in
			switch result {
			case .success(let events):
				completion(.success(events))
			case .failure(let error):
				completion(.failure(error))
			}
		}
	}
}
