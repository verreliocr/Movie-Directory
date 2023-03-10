//
//  IRouter.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

protocol IRouter: AnyObject {
    func setNavigationController(_ nav: UINavigationController)
    func setRoot(to module: FeatureModule, window: UIWindow?, using params: [String: Any])
    func push(module: FeatureModule, using params: [String: Any])
    func present(module: FeatureModule, asNavigation: Bool, using params: [String: Any])
}
