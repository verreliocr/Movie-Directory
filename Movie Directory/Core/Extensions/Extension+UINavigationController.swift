//
//  Extension+UINavigationController.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func hideBarIfNecessary() {
        if self.isNavigationBarHidden != true {
            self.setNavigationBarHidden(true, animated: true)
        }
    }
    
    func showBarIfNecessary() {
        if self.isNavigationBarHidden {
            self.setNavigationBarHidden(false, animated: true)
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return self.viewControllers.count > 1
    }
}
