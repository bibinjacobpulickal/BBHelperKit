//
//  BBValidatable.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

import Foundation

public protocol BBValidatable {
    var regex: String { get }
    var errorMessage: String { get }
}

public extension String {

    func validateUsingBBPattern(_ pattern: String) throws -> Bool {
        let regex = try NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: utf16.count)
        return regex.firstMatch(in: self, options: [], range: range) != nil
    }

    @available(*, unavailable, renamed: "validateUsingBBValidator(_:message:)")
    func validate(using validator: BBValidatable, message: ((String) -> Void)? = nil) throws -> Bool { false }

    func validateUsingBBValidator(_ validator: BBValidatable, message: ((String) -> Void)? = nil) throws -> Bool {
        let bool = try validateUsingBBPattern(validator.regex)
        if bool {
            message?("")
        } else {
            message?(validator.errorMessage)
        }
        return bool
    }
}
