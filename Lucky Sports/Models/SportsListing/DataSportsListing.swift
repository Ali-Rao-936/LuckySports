//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 10, 2023
//
import Foundation
import SwiftyJSON

struct DataSportsListing {

	let id: Int?
	let title: String?
	let keywords: String?
	let description: String?
	let price: String?
	let coverPath: String?
	let thumbnailPath: String?
	let createdAt: String?
	let updatedAt: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		title = json["title"].stringValue
		keywords = json["keywords"].stringValue
		description = json["description"].stringValue
		price = json["price"].stringValue
		coverPath = json["cover_path"].stringValue
		thumbnailPath = json["thumbnail_path"].stringValue
		createdAt = json["created_at"].stringValue
		updatedAt = json["updated_at"].stringValue
	}

}
