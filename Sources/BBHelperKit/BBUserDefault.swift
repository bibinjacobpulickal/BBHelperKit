//
//  UserDefaultHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

import Foundation

@propertyWrapper
public struct BBCodableUserDefault<Type: Codable> {

    public let key: String

    public init(forKey key: String) {
        self.key = key
    }

    public var wrappedValue: Type? {
        get {
            if let data = UserDefaults.standard.data(forKey: key) {
                return try? JSONDecoder().decode(Type.self, from: data)
            }
            return nil
        }
        set {
            if let object = newValue, let data = try? JSONEncoder().encode(object) {
                UserDefaults.standard.set(data, forKey: key)
            } else {
                UserDefaults.standard.set(newValue, forKey: key)
            }
        }
    }
}

@propertyWrapper
public struct BBUserDefault<Type> {

    public let value: Type
    public let key: String

    public var wrappedValue: Type? {
        get { UserDefaults.standard.object(forKey: key) as? Type ?? value }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}

public extension BBUserDefault {
    
    init(setValue value: Type, forKey key: String) {
        self.init(value: value, key: key)
    }
}

@propertyWrapper
public struct BBOptionalUserDefault<Type> {

    public let key: String

    public init(forKey key: String) {
        self.key = key
    }

    public var wrappedValue: Type? {
        get { UserDefaults.standard.object(forKey: key) as? Type }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
}
