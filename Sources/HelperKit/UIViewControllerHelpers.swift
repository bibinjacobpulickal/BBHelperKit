//
//  UIViewControllerHelpers.swift
//  Staragent
//
//  Created by Bibin Jacob Pulickal on 24/03/20.
//  Copyright © 2020 bibinjacobpulickal. All rights reserved.
//

#if canImport(UIKit)
import UIKit.UIViewController
#endif

extension UIViewController {

    func showAlert(_ title: String? = "Error!",
                   message: String?,
                   actions: [String: UIAlertAction.Style] = [:],
                   handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Okay", style: .default))
        } else {
            for action in actions {
                alert.addAction(UIAlertAction(title: action.key, style: action.value, handler: handler))
            }
        }
        present(alert, animated: true)
    }

    func presentActivityIndicator(completion: (() -> Void)? = nil) {

        let alert            = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))

        loadingIndicator.hidesWhenStopped = true
        if #available(iOS 13.0, *) {
            loadingIndicator.style            = .large
        } else {
            loadingIndicator.style            = .whiteLarge
        }

        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)

        present(alert, animated: true, completion: completion)
    }
}
