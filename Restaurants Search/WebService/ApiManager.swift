//
//  ApiManager.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation
import Alamofire
import SwiftyJSON

var authHeaders: HTTPHeaders = ["Authorization": "Bearer XPFgzKwZGK1yqRxHi0d5xsARFOLpXIvccQj5jekqTnysweGyoIfVUHcH2tPfGq5Oc9kwKHPkcOjk2d1Xobn7aTjOFeop8x41IUfVvg2Y27KiINjYPADcE7Qza0RkX3Yx"]

struct Resource<T> {
    let url: URL
    let parse: (Data) ->  T?
}

final class ApiManager {
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        AF.request(resource.url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: authHeaders).responseJSON { (response) in
            
            switch(response.result) {
            case .success(_):
                if let data = response.data {
                    DispatchQueue.main.async {
                        completion(resource.parse(data))
                    }
                }
                break
                
            case .failure(_):
                completion(nil)
                break
                
            }
        }
    }
}
