//
//  SportsListingRandom.swift
//  Club Sports
//
//  Created by Yahya on 3/11/23.
//

import Foundation
import SwiftyJSON

struct SportsListingRandom {

    let data: [DataSportsListing]?
    let dt: String?
    let v: String?
    let s: String?

    init(_ json: JSON) {
        data = json["data"].arrayValue.map { DataSportsListing($0) }
        dt = json["dt"].stringValue
        v = json["v"].stringValue
        s = json["s"].stringValue
    }

}
