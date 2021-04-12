//
//  ColorHelpers.swift
//  
//
//  Created by Bibin Jacob Pulickal on 26/11/20.
//

#if canImport(SwiftUI)
import SwiftUI

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public struct ForEachColorScheme<Content> {

    /// A function that can be used to generate content on demand given
    public var content: () -> Content
    
    public init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension ForEachColorScheme: View where Content: View {
    public var body: some View {
        ForEach(ColorScheme.allCases) {
            content()
                .environment(\.colorScheme, $0)
        }
    }
}


@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
extension ColorScheme: Identifiable {
    public var id: Int { hashValue }
}

@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {

    @inlinable func backgroundColor(_ color: Color, alignment: Alignment = .center) -> some View {
        background(color, alignment: alignment)
    }
}

#if canImport(UIKit)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {

    @inlinable func backgroundColor(uiColor: UIColor, alignment: Alignment = .center) -> some View {
        background(Color(uiColor), alignment: alignment)
    }
}
#endif

#if canImport(AppKit)
@available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
public extension View {

    @inlinable func backgroundColor(nsColor: NSColor, alignment: Alignment = .center) -> some View {
        background(Color(nsColor), alignment: alignment)
    }
}
#endif
#endif
