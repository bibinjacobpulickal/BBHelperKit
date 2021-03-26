//
//  BBCaseIterableDefaults.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 04/06/20.
//  Copyright © 2020 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

// BBCaseIterableDefaults can be used in scenarios where Codable enums are missing case/cases or new case/cases are to be added and should be defaulted to the first case (preferably use `default` as the first case).
protocol BBCaseIterableDefaults: Codable & CaseIterable & RawRepresentable where RawValue: Codable, AllCases: BidirectionalCollection { }

extension BBCaseIterableDefaults {

    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.allCases.first!
    }
}

