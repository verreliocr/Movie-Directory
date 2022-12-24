//
//  AppRouter.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

class AppRouter: IRouter {
    private var navigationController: UINavigationController!
    
    func setNavigationController(_ nav: UINavigationController) {
        navigationController = nav
    }
    
    func setRoot(to module: FeatureModule, window: UIWindow? = nil, using params: [String : Any] = [:]) {
        let module = module.create(using: self)
        let viewController: UIViewController = module.resolve(using: params)
        let navigationController = UINavigationController(rootViewController: viewController)
        self.navigationController = navigationController
        module.router.setNavigationController(navigationController)
        window?.rootViewController = navigationController
    }
    
    func push(module: FeatureModule, using params: [String : Any] = [:]) {
        let module = module.create(using: self)
        let viewController: UIViewController = module.resolve(using: params)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func present(module: FeatureModule, asNavigation: Bool = false, using params: [String : Any] = [:]) {
        if asNavigation {
            let appRouter = AppRouter()
            let module = module.create(using: appRouter)
            let viewController: UIViewController = module.resolve(using: params)
            let nav = UINavigationController(rootViewController: viewController)
            module.router.setNavigationController(nav)
            navigationController.present(nav, animated: true, completion: nil)
        } else {
            let module = module.create(using: self)
            let viewController: UIViewController = module.resolve(using: params)
            navigationController.present(viewController, animated: true, completion: nil)
        }
    }
}
