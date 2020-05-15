//
//  File.swift
//
//
//  Created by Bibin Jacob Pulickal on 10/04/20.
//

#if canImport(UIKit)
import UIKit.UIViewController

extension UIViewController {

    public func showAlert(_ title: String? = "Error!",
                   message: String?,
                   actions: [String: UIAlertAction.Style] = [:],
                   handler: ((UIAlertAction) -> Void)? = nil,
                   setup: ((UIAlertController) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.isEmpty {
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: handler))
        } else {
            for action in actions {
                alert.addAction(UIAlertAction(title: action.key, style: action.value, handler: handler))
            }
        }
        setup?(alert)
        present(alert, animated: true)
    }

    public func presentActivityIndicator(completion: (() -> Void)? = nil) {

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
#endif
