//
//  Categories.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Categories : Codable {
	let alias : String?
	let title : String?

	enum CodingKeys: String, CodingKey {

		case alias = "alias"
		case title = "title"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		alias = try values.decodeIfPresent(String.self, forKey: .alias)
		title = try values.decodeIfPresent(String.self, forKey: .title)
	}

}
