//
//  Extension+UIViewController.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

extension UIViewController {
    func handleKeyboarrd() {
        view.addAction { [unowned self] in
            self.dismissKeyboard()
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.size.height == UIScreen.main.bounds.height {
                self.view.frame.size.height -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.size.height = UIScreen.main.bounds.height
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    static func topViewController(controller: UIViewController? = UIApplication.shared.currentWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
    
    func showOfflineAlert(retryAction: @escaping (() -> Void)) {
        let alert = UIAlertController(title: "You seem to be offline", message: "Make sure your phone has an active internet connection.", preferredStyle: .alert)
        let retryButton = UIAlertAction(title: "Try Again", style: .default) { (_) in
            retryAction()
        }
        let settingButton = UIAlertAction(title: "Setting", style: .default) { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        alert.addAction(retryButton)
        alert.addAction(settingButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showMaintenanceAlert(retryAction: @escaping (() -> Void), cancelAction: @escaping (() -> Void) = { }) {
        let alert = UIAlertController(title: "We will be back soon", message: "We are under maintenance. Please try again later", preferredStyle: .alert)
        let retryButton = UIAlertAction(title: "Try Again", style: .default) { (_) in
            retryAction()
        }
        let thanksButton = UIAlertAction(title: "No Thanks", style: .default) { _ in
            cancelAction()
        }
        alert.addAction(thanksButton)
        alert.addAction(retryButton)
        present(alert, animated: true, completion: nil)
    }
    
    func showMessage(_ message: String, title: String) {
        showMessage(message, title: title, completion: nil)
    }
    
    func showMessage(_ message: String, title: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
