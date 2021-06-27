//
//  RestaurantsResultsViewModel.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation

class RestaurantsListResultsViewModel {
    private var restaurantsListResults = [Businesses]()
    
    //MARK: - Add Restaurants
    /**
      - Parameters:
        - isForFirstTime: If you want to reset all your restaurants list pass this parameter as true otherwise false
        - results:All restaurants information in the form of array
     */
    func addResult(isForFirstTime: Bool = true, results: [Businesses]) {
        if isForFirstTime {
            restaurantsListResults = results
        } else {
            restaurantsListResults.append(contentsOf: results)
        }
    }
    
    //MARK: - Get Total count of Restaurants
    func countOfRestaurants() -> Int {
        return restaurantsListResults.count
    }
    
    //MARK:- Get Total count of Restaurants if we create any section
    func numberOfRows(_ section: Int) -> Int {
        return restaurantsListResults.count
    }
    
    //MARK: - Get Restaurants at particular position
    func modelAt(_ index: Int) -> Businesses {
        return restaurantsListResults[index]
    }
    
    
}


class RestaurantsResultsViewModel {
    let restaurantsResults: SearchResponse
    
    init(response: SearchResponse) {
        self.restaurantsResults = response
    }
    
    //MARK: - Getting total count of restaurants
    var totalCount: Int {
        if let count = restaurantsResults.total {
            return count
        } else {
            return 0
        }
    }
}
