//
//  SearchResponse.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct SearchResponse : Codable {
	let businesses : [Businesses]?
	let total : Int?
	let region : Region?

	enum CodingKeys: String, CodingKey {

		case businesses = "businesses"
		case total = "total"
		case region = "region"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		businesses = try values.decodeIfPresent([Businesses].self, forKey: .businesses)
		total = try values.decodeIfPresent(Int.self, forKey: .total)
		region = try values.decodeIfPresent(Region.self, forKey: .region)
	}

}
