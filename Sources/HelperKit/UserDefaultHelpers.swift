//
//  File.swift
//  
//
//  Created by Bibin Jacob Pulickal on 25/04/20.
//

import Foundation

@propertyWrapper
public struct CodableUserDefault<T: Codable> {

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

@propertyWrapper
public struct UserDefault<T> {

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

public extension UserDefault {
    
    init(setValue value: T, forKey key: String) {
        self.init(value: value, key: key)
    }
}

@propertyWrapper
public struct OptionalUserDefault<T> {

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
