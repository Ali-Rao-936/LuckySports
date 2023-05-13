//
//  SportsListingBase.swift
//
//  Generated using https://jsonmaster.github.io
//  Created on March 10, 2023
//
import Foundation
import SwiftyJSON

struct SportsListingBase {

	var data: [DataSportsListing]?
	let links: LinksSportsListing?
	let meta: MetaSportsListing?
	let dt: String?
	let v: String?
	let s: String?

	init(_ json: JSON) {
		data = json["data"].arrayValue.map { DataSportsListing($0) }
		links = LinksSportsListing(json["links"])
		meta = MetaSportsListing(json["meta"])
		dt = json["dt"].stringValue
		v = json["v"].stringValue
		s = json["s"].stringValue
	}
    
}
