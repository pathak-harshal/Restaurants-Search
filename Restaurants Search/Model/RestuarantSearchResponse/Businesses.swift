//
//  Businesses.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
struct Businesses : Codable {
    let id : String?
    let alias : String?
    let name : String?
    let image_url : String?
    let is_closed : Bool?
    let url : String?
    let review_count : Int?
    let categories : [Categories]?
    let rating : Double?
    let coordinates : Coordinates?
    let transactions : [String]?
    let price : String?
    var location : Location?
    let phone : String?
    let display_phone : String?
    var distanceWithAddress: String = ""
    var distance : Double?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case alias = "alias"
        case name = "name"
        case image_url = "image_url"
        case is_closed = "is_closed"
        case url = "url"
        case review_count = "review_count"
        case categories = "categories"
        case rating = "rating"
        case coordinates = "coordinates"
        case transactions = "transactions"
        case price = "price"
        case location = "location"
        case phone = "phone"
        case display_phone = "display_phone"
        case distance = "distance"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        alias = try values.decodeIfPresent(String.self, forKey: .alias)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        is_closed = try values.decodeIfPresent(Bool.self, forKey: .is_closed)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        review_count = try values.decodeIfPresent(Int.self, forKey: .review_count)
        categories = try values.decodeIfPresent([Categories].self, forKey: .categories)
        rating = try values.decodeIfPresent(Double.self, forKey: .rating)
        coordinates = try values.decodeIfPresent(Coordinates.self, forKey: .coordinates)
        transactions = try values.decodeIfPresent([String].self, forKey: .transactions)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        location = try values.decodeIfPresent(Location.self, forKey: .location)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        display_phone = try values.decodeIfPresent(String.self, forKey: .display_phone)
        distance = try values.decodeIfPresent(Double.self, forKey: .distance)
    }
    
}
