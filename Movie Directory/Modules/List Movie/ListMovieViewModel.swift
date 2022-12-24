//
//  ListMovieViewModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

class ListMovieViewModel: IModule {
    
    weak var view: IListMovieView?
    let model = ListMovieModel()
    let request = HTTPRequest()
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        let view = ListMovieView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    private func getListMovie(appendResult: Bool = false, completion: ((ErrorType?) -> Void)? = nil) {
        request.call(.getDiscoverMovie(page: model.page), bodyParams: [:]) { [weak self] data, type in
            if let response = BaseResponse<[ListMovieObject]>.decode(from: data) {
                self?.model.totalPages = response.totalPages ?? 0
                self?.model.totalElements = response.totalResults ?? 0
                if appendResult {
                    self?.model.movies.append(contentsOf: response.results ?? [])
                } else {
                    self?.model.movies = response.results ?? []
                }
                self?.view?.reloadView()
            }else if let type = type {
                self?.handleError(type: type, retryAction: { [weak self] in
                    self?.getListMovie(appendResult: appendResult)
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

extension ListMovieViewModel: IListMoviesViewModel {
    func setView(_ view: IListMovieView) {
        self.view = view
    }
    
    func viewWillAppear() {
        getListMovie(appendResult: true)
    }
    
    func getNumberOfMovie() -> Int {
        return model.movies.count
    }
    
    func getImageURL(at item: Int) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(model.movies[item].posterPath ?? "")")!
    }
    
    func willDisplayCell(at item: Int) {
        if model.allowRequestNextPage, item == getNumberOfMovie() - 1, model.movies.count < model.totalElements {
            model.allowRequestNextPage = false
            let prevPage = model.page
            model.page += 1
            getListMovie(appendResult: true) { [weak self] error in
                self?.model.allowRequestNextPage = true
                if error != nil {
                    self?.model.page = prevPage
                }
            }
        }
    }
    
    func didSelectMovie(at item: Int) {
        let id = model.movies[item].id ?? 0
        router.push(module: .detailMovie, using: ["id" : id])
    }
    
    
}
