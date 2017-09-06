//
//  Events.swift
//  CSAFF
//
//  Created by Vaibhav Parmar on 04/09/17.
//  Copyright © 2017 Nickelfox Technologies. All rights reserved.
//

import Foundation
import APIClient

public typealias APICompletion<T> = (APIResult<T>) -> Void

public struct EventResponse: JSONParseable {
	var events: [Event]
	public static func parse(_ json: JSON) throws -> EventResponse {
		let eventResponse  = try EventResponse(events: json["events"]^^)
		return eventResponse
	}
}

public struct Event: JSONParseable {
	var name: String
	var imageURL: String
	var orgainizerId: String
	
	public static func parse(_ json: JSON) throws -> Event {
		let event  = try Event(name: json["name"]["text"]^,
		                       imageURL: json["logo"]["original"]["url"]^,
		                       orgainizerId: json["organizer_id"]^)
		return event
	}
}
