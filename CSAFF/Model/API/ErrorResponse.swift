//
//  ErrorResponse.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient

private let errorKey = "error"

public struct ErrorResponse: ErrorResponseProtocol {
	public static func parse(_ json: JSON, code: Int) throws -> ErrorResponse {
		//		let jsonArray = json.array
		let error = APIErrorType.unknown
		throw error
	}
	
	public var code: Int
	public let messages: [String]
	public var compiledErrorMessage: String {
		return self.messages.joined(separator: ",")
	}
	
	public var message: String {
		return self.compiledErrorMessage
	}
	
	public var title: String {
		return ""
	}
}
