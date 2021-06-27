//
//  AllUrls.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation

struct AllUrls {
    static let searchURL = "https://api.yelp.com/v3/businesses/search?"
    
    //MARK:- Get Restaurants
    /**
      - Parameters:
        - withBusiness: Search term, for example "food" or "restaurants". The term may also be business names, such as "Starbucks". If term is not                                          included the endpoint will default to searching across businesses from a small number of popular categories.
        - withLocation: Required if either latitude or longitude is not provided. This string indicates the geographic area to be used when searching for                                      businesses. Examples: "New York City", "NYC", "350 5th Ave, New York, NY 10118". Businesses returned in the response may                                     not be strictly within the specified location.
        - withinRange:  A suggested search radius in meters. This field is used as a suggestion to the search. The actual search radius may be lower                                        than the suggested radius in dense urban areas, and higher in regions of less business density. If the specified value is too                                           large, a AREA_TOO_LARGE error may be returned. The max value is 40000 meters (about 25 miles).
        - sortedWith:   Suggestion to the search algorithm that the results be sorted by one of the these modes: best_match, rating, review_count or                                       distance. The default is best_match. Note that specifying the sort_by is a suggestion (not strictly enforced) to Yelp's search,                                          which considers multiple input parameters to return the most relevant results. For example, the rating sort is not strictly sorted                                       by the rating value, but by an adjusted rating value that takes into account the number of ratings, similar to a Bayesian                                                  average. This is to prevent skewing results to businesses with a single review.
        - withLimit:    Number of business results to return. By default, it will return 20. Maximum is 50.
        - withOffset:   The list of returned business results by this amount.
     */
    static func getSearchUrl(
        withBusiness: String = "restaurants",
        withLocation: String = "NYC",
        withinRange: Int = 500,
        sortedWith: String = "distance",
        withLimit: Int = 15,
        withOffset: Int = 0) -> String {
        
        return searchURL + "term=\(withBusiness)&location=\(withLocation)&radius=\(withinRange)&sort_by=\(sortedWith)&limit=\(withLimit)&offset=\(withOffset)"
    }
}
