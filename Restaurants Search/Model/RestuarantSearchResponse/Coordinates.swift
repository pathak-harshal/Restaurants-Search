//
//  Coordinates.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Coordinates : Codable {
	let latitude : Double?
	let longitude : Double?

	enum CodingKeys: String, CodingKey {

		case latitude = "latitude"
		case longitude = "longitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
	}

}
