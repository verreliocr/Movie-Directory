//
//  FeatureModule.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

enum FeatureModule {
    case listMovie

    func create(using router: IRouter) -> IModule {
        switch self {
        case .listMovie:
            return ListMovieViewModel(router: router)
        }
    }
}
