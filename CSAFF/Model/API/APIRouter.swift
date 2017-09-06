//
//  APIRouter.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient

public enum APIRouter: Router {
	case fetchCities
	case fetchEvents
	case fetchSchedule(event: String)
	
	
	public var method:HTTPMethod {
		let method: HTTPMethod
		switch self {
		case .fetchCities, .fetchEvents, .fetchSchedule:
			method = .get
		}
		return method
	}
	
	public var path: String {
		switch self {
		case .fetchCities: return ""
		//case .fetchEvents: return "/events/search/"
		case .fetchEvents: return "/users/me/owned_events"
		case .fetchSchedule(let event): return "\(event)"
		}
		//users/me/owned_event
	}
	
	public var params: [String : Any] {
		var parameters: [String: Any]
		//var shouldAddOAuth = true
		switch self {
		case .fetchCities(let city): parameters = ["city": city]
		case .fetchEvents: return ["token" : ModelConfig.personalOAuth]
		case .fetchSchedule(let event): parameters = ["event" : event]
		}
		//parameters["oAuth"] = ModelConfig.personalOAuth
		return parameters
	}
	
	public var baseUrl: URL {
		let url = URL(string: ModelConfig.baseUrl)!
		return url
	}
	
	public var headers: [String : String] {
		return ["Accept": "application/json", "Content-Type": "application/json"]
	}
	
	public var encoding: URLEncoding? {
		return nil
	}
	
	public var timeoutInterval: TimeInterval? {
		return nil
	}
	
	public var keypathToMap: String? {
		return nil
	}
	
}
