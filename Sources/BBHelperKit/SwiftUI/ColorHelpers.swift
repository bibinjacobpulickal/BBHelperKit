//
//  ColorHelpers.swift
//  
//
//  Created by Bibin Jacob Pulickal on 26/11/20.
//

import SwiftUI

@available(OSX 10.15, *)
@available(iOS 13.0, *)
public struct ForEachColorScheme<Content: View>: View {
    public var content: () -> Content
    public var body: some View {
        ForEach(ColorScheme.allCases) {
            content()
                .environment(\.colorScheme, $0)
        }
    }
}


@available(OSX 10.15, *)
@available(iOS 13.0, *)
extension ColorScheme: Identifiable {
    public var id: Int { hashValue }
}

@available(OSX 10.15, *)
@available(iOS 13.0, *)
public extension View {

    @inlinable func backgroundColor(_ color: Color, alignment: Alignment = .center) -> some View {
        background(color, alignment: alignment)
    }
}

#if canImport(UIKit)
@available(OSX 10.15, *)
@available(iOS 13.0, *)
public extension View {

    @inlinable func backgroundColor(uiColor: UIColor, alignment: Alignment = .center) -> some View {
        background(Color(uiColor), alignment: alignment)
    }
}
#endif

#if canImport(AppKit)
@available(OSX 10.15, *)
@available(iOS 13.0, *)
public extension View {

    @inlinable func backgroundColor(nsColor: NSColor, alignment: Alignment = .center) -> some View {
        background(Color(nsColor), alignment: alignment)
    }
}
#endif
