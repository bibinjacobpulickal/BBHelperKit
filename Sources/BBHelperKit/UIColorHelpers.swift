//
//  UIColorHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

#if canImport(UIKit)

import UIKit.UIColor

extension UIColor {

    static var random: UIColor {
        UIColor(red: .random(in: 0...1),
                green: .random(in: 0...1),
                blue: .random(in: 0...1),
                alpha: 1)
    }

    public convenience init?(hex: String) {
        let start     = hex.hasPrefix("#") ?
            hex.index(hex.startIndex, offsetBy: 1) :
            hex.index(hex.startIndex, offsetBy: 0)
        let hexColor  = String(hex[start...])
        let scanner   = Scanner(string: hexColor)
        var hexNumber = UInt64(0)

        if scanner.scanHexInt64(&hexNumber) {
            if hexColor.count == 8 {
                self.init(
                    red: CGFloat((hexNumber & 0xff000000) >> 24) / 255,
                    green: CGFloat((hexNumber & 0x00ff0000) >> 16) / 255,
                    blue: CGFloat((hexNumber & 0x0000ff00) >> 8) / 255,
                    alpha: CGFloat(hexNumber & 0x000000ff) / 255)
                return
            } else if hexColor.count == 6 {
                self.init(
                    red: CGFloat((hexNumber & 0xff0000) >> 16) / 255,
                    green: CGFloat((hexNumber & 0x00ff00) >> 8) / 255,
                    blue: CGFloat(hexNumber & 0x0000ff) / 255, alpha: 1)
                return
            }
        }
        return nil
    }
}
#endif
