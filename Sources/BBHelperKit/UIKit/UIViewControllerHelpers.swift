//
//  UIViewControllerHelpers.swift
//  BBHelperKit
//
//  Created by Bibin Jacob Pulickal on 20/05/20.
//

#if canImport(UIKit)
import UIKit.UIViewController

extension UIViewController {

    @available(*, unavailable, message: "Use 'BBAlert' package's 'showBBAlert' method instead")
    public func showAlert(_ title: String? = "Error!",
                   message: String?,
                   actions: [String: UIAlertAction.Style] = [:],
                   handler: ((UIAlertAction) -> Void)? = nil,
                   setup: ((UIAlertController) -> Void)? = nil) { }

    @available(*, unavailable, message: "Use 'BBLoader' package's 'presentBBLoader' method instead")
    public func presentActivityIndicator(completion: (() -> Void)? = nil) { }
}
#endif
