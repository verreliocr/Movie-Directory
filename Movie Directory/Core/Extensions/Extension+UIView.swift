//
//  Extension+UIView.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit
import QuartzCore

typealias Closure = () -> ()

///
class ClosureSleeve {
    let closure: Closure
    init(_ closure: @escaping Closure) {
        self.closure = closure
    }
    @objc func invoke () {
        closure()
    }
}

extension UIView {
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        } set {
            clipsToBounds = true
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var selfCornerRadius: Bool {
        get {
            return false
        } set {
            if newValue {
                self.layer.cornerRadius = self.frame.size.height / 2
            } else {
                self.layer.cornerRadius = 0.0
            }
        }
    }
    
    func addAction(for controlEvents: UIControl.Event = .touchUpInside, _ closure: @escaping Closure) {
        let sleeve = ClosureSleeve(closure)
        let gesture = UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        gesture.numberOfTapsRequired = 1
        addGestureRecognizer(gesture)
        isUserInteractionEnabled = true
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }

}
