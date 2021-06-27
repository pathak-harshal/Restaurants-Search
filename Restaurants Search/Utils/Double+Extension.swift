//
//  Double+Extension.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import Foundation

extension Double {
    //MARK: - Getting String with 2 decimal places
    func getDispalyValue() -> String {
        return String(format: "%.2F", self)
    }
    //MARK: - Convert double to integer
    func getRoundedValue() -> Int {
        if self >= Double(Int.min) && self < Double(Int.max) {
            return Int(self)
        } else {
            return 0
        }
    }
}
