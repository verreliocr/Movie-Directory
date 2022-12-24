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
    func getImageURL(at row: Int) -> URL
    func getTitleMovie(at row: Int) -> String
    func willDisplayCell(at row: Int)
    func didSelectMovie(at row: Int)
}
