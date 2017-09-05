//
//  AuthHeaders.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient

private let accessTokenKey = "access-token"
public struct AuthHeaders : AuthHeadersProtocol {
	let accessToken: String
	
	public static func parse(_ json: JSON) throws -> AuthHeaders {
		return try AuthHeaders(accessToken: json[accessTokenKey]^)
	}
	
	public func toJSON() -> [String: String] {
		let res: [String: String] = [
			accessTokenKey: self.accessToken
		]
		return res
	}
	
	public var isValid: Bool {
		return !self.accessToken.isEmpty
	}
		
	public func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
		var urlRequest = urlRequest
		urlRequest.setValue(self.accessToken, forHTTPHeaderField: "Access-Token")
		return urlRequest
	}
}
