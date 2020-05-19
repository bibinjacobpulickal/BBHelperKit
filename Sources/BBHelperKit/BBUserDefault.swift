//
//  UserDefaultHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

import Foundation

@available(*, unavailable, renamed: "BBCodableUserDefault")
public struct CodableUserDefault<T: Codable> { }

@propertyWrapper
public struct BBCodableUserDefault<T: Codable> {

    public let key: String

    public init(forKey key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            if let data = UserDefaults.standard.data(forKey: key) {
                return try? JSONDecoder().decode(T.self, from: data)
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

@available(*, unavailable, renamed: "BBUserDefault")
public struct UserDefault<T> { }

@propertyWrapper
public struct BBUserDefault<T> {

    public let value: T
    public let key: String

    public var wrappedValue: T {
        get {
            return UserDefaults.standard.object(forKey: key) as? T ?? value
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

public extension BBUserDefault {
    
    init(setValue value: T, forKey key: String) {
        self.init(value: value, key: key)
    }
}

@available(*, unavailable, renamed: "BBOptionalUserDefault")
public struct OptionalUserDefault<T> { }

@propertyWrapper
public struct BBOptionalUserDefault<T> {

    public let key: String

    public init(forKey key: String) {
        self.key = key
    }

    public var wrappedValue: T? {
        get {
            return UserDefaults.standard.object(forKey: key) as? T
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}
