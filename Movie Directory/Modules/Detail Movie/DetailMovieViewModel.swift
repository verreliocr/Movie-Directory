//
//  DetailMovieViewModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

class DetailMovieViewModel: IModule {
    
    weak var view: IDetailMovieView?
    let model = DetailMovieModel()
    let request = HTTPRequest()
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        model.movieId = params["id"] as! Int
        let view = DetailMovieView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    private func getDetailMovie() {
        request.call(.getDetailMovie(id: model.movieId), bodyParams: [:]) { [weak self] data, type in
            if let res = DetailMovieResponse.decode(from: data) {
                self?.model.detailMovie = res
                self?.getYoutubeVideo()
            }else if let type = type {
                self?.handleError(type: type, retryAction: { [weak self] in
                    self?.getDetailMovie()
                })
            }
        }
    }
    
    private func getYoutubeVideo() {
        request.call(.getVideo(id: model.movieId), bodyParams: [:]) { [weak self] data, type in
            if let res = BaseResponse<[VideoObject]>.decode(from: data) {
                self?.model.youtubeKey = res.results?.filter({ $0.type?.isTrailer ?? false }).first?.key ?? ""
                self?.view?.reloadView()
            }else if let type = type {
                self?.handleError(type: type, retryAction: { [weak self] in
                    self?.getYoutubeVideo()
                })
            }
        }
    }
    
    func handleError(type: ErrorType, retryAction: @escaping (() -> Void)) {
        switch type {
        case .noConnection:
            self.view?.showOfflineAlert {
                retryAction()
            }
        case .serverError:
            self.view?.showMaintenanceAlert(retryAction: {
                retryAction()
            }, cancelAction: nil)
        }
    }
}

extension DetailMovieViewModel: IDetailMovieViewModel {
    func setView(_ view: IDetailMovieView) {
        self.view = view
    }
    
    func viewWillAppear() {
        getDetailMovie()
    }
    
    func getImageURL() -> URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500\(model.detailMovie.posterPath ?? "")")
    }
    
    func getTitleMovie() -> String {
        return model.detailMovie.title ?? ""
    }
    
    func getRate() -> String {
        return "\(model.detailMovie.voteAverage ?? 0) (\(model.detailMovie.voteCount ?? 0))"
    }
    
    func getGenre() -> String {
        guard let genres = model.detailMovie.genres
            else { return "" }
        return genres.map({ $0.name ?? "" }).joined(separator: ", ")
    }
    
    func getOverview() -> String {
        return model.detailMovie.overview ?? ""
    }
    
    func getReleaseDate() -> String {
        return model.detailMovie.releaseDate ?? ""
    }
    
    func getYoutubeKey() -> String {
        return model.youtubeKey
    }
    
    func didSelectReviews() {
        router.present(module: .listReviews, asNavigation: true, using: ["id": model.movieId])
    }
}
