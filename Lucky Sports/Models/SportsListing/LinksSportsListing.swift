//
//  Links.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 10, 2023
//
import Foundation
import SwiftyJSON

struct LinksSportsListing {

	let url: String?
	let label: String?
	let active: Bool?

	init(_ json: JSON) {
		url = json["url"].stringValue
		label = json["label"].stringValue
		active = json["active"].boolValue
	}

}
