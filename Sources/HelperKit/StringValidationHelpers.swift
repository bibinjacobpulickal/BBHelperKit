//
//  File.swift
//  
//
//  Created by Bibin Jacob Pulickal on 26/04/20.
//

import Foundation

public protocol Validatable {
    var regex: String { get }
    var errorMessage: String { get }
}

public extension String {

    func validate(using validator: Validatable, message: (String) -> Void) -> Bool {
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
