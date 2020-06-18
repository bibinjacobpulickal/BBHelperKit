//
//  UIImageViewHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

#if canImport(UIKit)
import UIKit.UIImageView

let cache = NSCache<NSString, UIImage>()

public protocol BBURLNSStringConvertible {
    func asUrl() -> URL?
    func asString() -> NSString
}

extension String: BBURLNSStringConvertible {
    public func asUrl() -> URL? { URL(string: self) }
    public func asString() -> NSString { NSString(string: self) }
}

extension URL: BBURLNSStringConvertible {
    public func asUrl() -> URL? { self }
    public func asString() -> NSString { NSString(string: absoluteString) }
}

extension UIImageView {

    public func loadBBImage(
        _ url: BBURLNSStringConvertible?,
        placeholder: UIImage?     = nil,
        alwaysFetch: Bool         = false,
        completion: (() -> Void)? = nil) {
        BBImageLoader.loadBBImage(url, alwaysFetch: alwaysFetch) { [weak self] image in
            self?.image = image ?? placeholder
            completion?()
        }
    }
}

public enum BBImageLoader {

    static func loadBBImage(
        _ url: BBURLNSStringConvertible?,
        placeholder: UIImage? = nil,
        alwaysFetch: Bool     = false,
        _ completion: @escaping (UIImage?) -> Void) {
        guard let url = url?.asUrl() else {
            completion(placeholder)
            return
        }
        if let image = cache.object(forKey: url.asString()) {
            completion(image)
            if alwaysFetch {
                loadBBImageFromNetwork(url, completion)
            }
        } else {
            loadBBImageFromNetwork(url, completion)
        }
    }

    private static func loadBBImageFromNetwork(
        _ url: URL,
        placeholder: UIImage? = nil,
        _ completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cache.setObject(image, forKey: url.asString())
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    cache.removeObject(forKey: url.asString())
                    completion(placeholder)
                }
            }
        }
    }
}
#endif
