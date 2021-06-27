//
//  Region.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Region : Codable {
	let center : Center?

	enum CodingKeys: String, CodingKey {

		case center = "center"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		center = try values.decodeIfPresent(Center.self, forKey: .center)
	}

}
