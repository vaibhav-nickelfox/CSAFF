//
//  CSAFFAPIClient.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient


class CSAFFAPIClient: APIClient<AuthHeaders, ErrorResponse> {
	static let shared = CSAFFAPIClient()
	
	override init() {
		super.init()
		self.enableLogs = false
	}
}
