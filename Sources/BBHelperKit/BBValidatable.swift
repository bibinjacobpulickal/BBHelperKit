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

    func validate(using validator: BBValidatable, message: (String) -> Void) -> Bool {
        let bool = NSPredicate(
            format: "SELF MATCHES %@",
            validator.regex)
            .evaluate(with: self)
        if !bool {
            message(validator.errorMessage)
        }
        return bool
    }
}
