//
//  Meta.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 10, 2023
//
import Foundation
import SwiftyJSON

struct MetaSportsListing {

	let currentPage: Int?
	let from: Int?
	let lastPage: Int?
	let links: [Links]?
	let path: String?
	let perPage: Int?
	let to: Int?
	let total: Int?

	init(_ json: JSON) {
		currentPage = json["current_page"].intValue
		from = json["from"].intValue
		lastPage = json["last_page"].intValue
		links = json["links"].arrayValue.map { Links($0) }
		path = json["path"].stringValue
		perPage = json["per_page"].intValue
		to = json["to"].intValue
		total = json["total"].intValue
	}

}


struct Links {

    let selfField: String?

    init(_ json: JSON) {
        selfField = json["self"].stringValue
    }

}
