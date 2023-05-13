//
//  ProductParam.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 14, 2023
//
import Foundation
import SwiftyJSON

struct ProductParam {

	let id: Int?
	let title: String?
	let description: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		title = json["title"].stringValue
		description = json["description"].stringValue
	}

}