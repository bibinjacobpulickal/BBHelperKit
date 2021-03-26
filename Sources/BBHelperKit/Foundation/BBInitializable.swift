//
//  BBInitializable.swift
//  AutoLayoutProxy
//
//  Created by Bibin Jacob Pulickal on 10/01/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

#if canImport(Foundation)
import Foundation.NSObject
#endif

public protocol BBInitializable {
    init()
}

extension NSObject: BBInitializable { }

public func create<Object>(_ setup: (Object) -> Void) -> Object where Object: BBInitializable {
    let object = Object()
    setup(object)
    return object
}

public func create<T>(_ object: T, _ setup: (inout T) -> Void) -> T {
    var object = object
    setup(&object)
    return object
}
