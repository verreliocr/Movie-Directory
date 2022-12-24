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
}
