//
//  Center.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Center : Codable {
	let longitude : Double?
	let latitude : Double?

	enum CodingKeys: String, CodingKey {

		case longitude = "longitude"
		case latitude = "latitude"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
	}

}
