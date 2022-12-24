//
//  ListReviewsContract.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

protocol IListReviewsView: AnyObject {
    func reloadView()
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func showOfflineAlert(retryAction: @escaping (() -> Void))
    func showMaintenanceAlert(retryAction: @escaping (() -> Void), cancelAction: (() -> Void)?)
}

protocol IListReviewsViewModel {
    func setView(_ view: IListReviewsView)
    func viewWillAppear()
    func getTitlePage() -> String
    func getNumberOfRows() -> Int
    func getName(at row: Int) -> String
    func getReview(at row: Int) -> String
    func willDisplayCell(at row: Int)
}
