//
//  IModule.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

protocol IModule {
    var router: IRouter { get set }
    func resolve(using params: [String: Any]) -> UIViewController
}
