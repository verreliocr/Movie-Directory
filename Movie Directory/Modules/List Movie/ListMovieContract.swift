//
//  ListMoviesContract.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

protocol IListMovieView: AnyObject {
    func reloadView()
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func showOfflineAlert(retryAction: @escaping (() -> Void))
    func showMaintenanceAlert(retryAction: @escaping (() -> Void), cancelAction: (() -> Void)?)
}

protocol IListMoviesViewModel {
    func setView(_ view: IListMovieView)
    func viewWillAppear()
    func getNumberOfMovie() -> Int
    func getImageURL(at index: Int) -> URL?
}
