//
//  SportsProductDetail.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 14, 2023
//
import Foundation
import SwiftyJSON

struct SportsProductDetail {

	let data: ProductDetailData?
	let dt: String?
	let v: String?
	let s: String?

	init(_ json: JSON) {
		data = ProductDetailData(json["data"])
		dt = json["dt"].stringValue
		v = json["v"].stringValue
		s = json["s"].stringValue
	}

}
