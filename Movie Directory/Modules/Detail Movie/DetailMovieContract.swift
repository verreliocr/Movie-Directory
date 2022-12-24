//
//  DetailMovieContract.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

protocol IDetailMovieView: AnyObject {
    func reloadView()
    func showMessage(_ message: String, title: String, completion: (() -> Void)?)
    func showOfflineAlert(retryAction: @escaping (() -> Void))
    func showMaintenanceAlert(retryAction: @escaping (() -> Void), cancelAction: (() -> Void)?)
}

protocol IDetailMovieViewModel {
    func setView(_ view: IDetailMovieView)
    func viewWillAppear()
    func getTitlePage() -> String
    func getImageURL() -> URL?
    func getTitleMovie() -> String
    func getRate() -> String
    func getGenre() -> String
    func getOverview() -> String
    func getReleaseDate() -> String
    func getYoutubeKey() -> String
    func didSelectReviews()
}
