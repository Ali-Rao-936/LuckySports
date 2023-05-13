//
//  Data.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 14, 2023
//
import Foundation
import SwiftyJSON

struct ProductDetailData {

	let id: Int?
	let sku: String?
	let title: String?
	let keywords: String?
	let description: String?
	let content: String?
	let price: String?
	let coverPath: String?
	let thumbnailPath: String?
	let tag: [ProductDetailTag]?
	let productPhoto: [ProductPhoto]?
	let productParam: [ProductParam]?
	let createdAt: String?
	let updatedAt: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		sku = json["sku"].stringValue
		title = json["title"].stringValue
		keywords = json["keywords"].stringValue
		description = json["description"].stringValue
		content = json["content"].stringValue
		price = json["price"].stringValue
		coverPath = json["cover_path"].stringValue
		thumbnailPath = json["thumbnail_path"].stringValue
		tag = json["tag"].arrayValue.map { ProductDetailTag($0) }
		productPhoto = json["product_photo"].arrayValue.map { ProductPhoto($0) }
		productParam = json["product_param"].arrayValue.map { ProductParam($0) }
		createdAt = json["created_at"].stringValue
		updatedAt = json["updated_at"].stringValue
	}

}
