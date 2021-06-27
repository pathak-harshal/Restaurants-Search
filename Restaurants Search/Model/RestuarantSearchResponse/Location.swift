//
//  Location.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Location : Codable {
	let address1 : String?
	let address2 : String?
	let address3 : String?
	let city : String?
	let zip_code : String?
	let country : String?
	let state : String?
	let display_address : [String]?

	enum CodingKeys: String, CodingKey {

		case address1 = "address1"
		case address2 = "address2"
		case address3 = "address3"
		case city = "city"
		case zip_code = "zip_code"
		case country = "country"
		case state = "state"
		case display_address = "display_address"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		address1 = try values.decodeIfPresent(String.self, forKey: .address1)
		address2 = try values.decodeIfPresent(String.self, forKey: .address2)
		address3 = try values.decodeIfPresent(String.self, forKey: .address3)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		zip_code = try values.decodeIfPresent(String.self, forKey: .zip_code)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		display_address = try values.decodeIfPresent([String].self, forKey: .display_address)
	}

}
