//
//  DataHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 04/06/20.
//  Copyright © 2020 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

extension Data {

    /// `prettyPrintedJsonString` can be used in situations where you need to print out the json from the data exactly as it is received with all the formatting intact.
    var prettyPrintedJsonString: String {
        do {
            let object: Any = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves)
            let data = try JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
            return String(decoding: data, as: UTF8.self)
        } catch {
            return ""
        }
    }
}

