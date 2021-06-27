//
//  GetRestaurantsViewModel.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation

class GetRestaurantsViewModel {
    
    //MARK: - Getting restaurants with default value, if we want to change we can add any parameter from view controller otherwise it returns with these default values
    func getRestuarants(
        withBusiness: String = "restaurants",
        withLocation: String = "NYC",
        withinRange: Int = 500,
        sortedWith: String = "distance",
        withLimit: Int = 15,
        withOffset: Int = 0, completion: @escaping (RestaurantsResultsViewModel) -> Void) {
        
        //MARK: - Creating URL with parameter as this is GET method so every parameter is a part of URL only
        let restUrl = AllUrls.getSearchUrl(withBusiness: withBusiness, withLocation: withLocation, withinRange: withinRange, sortedWith: sortedWith, withLimit: withLimit, withOffset: withOffset)
        
        //MARK: - Creating Request and Result Resource of Restaurants Model
        let searchResource = Resource<SearchResponse>(url: URL(string: restUrl)!) { data in
            let searchResponse = try? JSONDecoder().decode(SearchResponse.self, from: data)
            return searchResponse
        }
        
        //MARK: - Calling API with Created Resource
        ApiManager().load(resource: searchResource) { result in
            if let restautantsResponse = result {
                let rm = RestaurantsResultsViewModel(response: restautantsResponse)
                completion(rm)
            }
        }
        
    }
}
