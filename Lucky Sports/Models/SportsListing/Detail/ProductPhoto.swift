//
//  ProductPhoto.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 14, 2023
//
import Foundation
import SwiftyJSON

struct ProductPhoto {

	let id: Int?
	let coverPath: String?
	let thumbnailPath: String?

	init(_ json: JSON) {
		id = json["id"].intValue
		coverPath = json["cover_path"].stringValue
		thumbnailPath = json["thumbnail_path"].stringValue
	}

}