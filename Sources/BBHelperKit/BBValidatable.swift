//
//  BBValidatable.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

import Foundation

@available(*, unavailable, renamed: "BBValidatable")
public protocol Validatable { }

public protocol BBValidatable {
    var regex: String { get }
    var errorMessage: String { get }
}

public extension String {

    func validate(using validator: BBValidatable, message: (String) -> Void) throws -> Bool {
        let regex = try NSRegularExpression(pattern: validator.regex)
        let range = NSRange(location: 0, length: utf16.count)
        let bool  = regex.firstMatch(in: self, options: [], range: range) != nil
        if bool {
            message("")
        } else {
            message(validator.errorMessage)
        }
        return bool
    }
}
