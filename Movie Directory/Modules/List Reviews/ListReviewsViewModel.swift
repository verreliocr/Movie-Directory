//
//  ListReviewsViewModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation
import UIKit

class ListReviewsViewModel: IModule {
    
    weak var view: IListReviewsView?
    let model = ListReviewsModel()
    let request = HTTPRequest()
    var router: IRouter
    
    init(router: IRouter) {
        self.router = router
    }
    
    func resolve(using params: [String : Any]) -> UIViewController {
        model.movieId = params["id"] as! Int
        let view = ListReviewsView(viewModel: self)
        self.setView(view)
        
        return view
    }
    
    private func getReviewsMovie(appendResult: Bool = false, completion: ((ErrorType?) -> Void)? = nil) {
        request.call(.getReviews(id: model.movieId, page: model.page), bodyParams: [:]) { [weak self] data, type in
            if let res = BaseResponse<[ReviewObject]>.decode(from: data) {
                self?.model.totalPages = res.totalPages ?? 0
                self?.model.totalElements = res.totalResults ?? 0
                if appendResult {
                    self?.model.reviews.append(contentsOf: res.results ?? [])
                } else {
                    self?.model.reviews = res.results ?? []
                }
                self?.view?.reloadView()
            }else if let type = type {
                self?.handleError(type: type, retryAction: { [weak self] in
                    self?.getReviewsMovie(appendResult: appendResult)
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

extension ListReviewsViewModel: IListReviewsViewModel {
    func setView(_ view: IListReviewsView) {
        self.view = view
    }
    
    func viewWillAppear() {
        getReviewsMovie()
    }
    
    func getNumberOfReviews() -> Int {
        return model.reviews.count
    }
    
    func getName(at index: Int) -> String {
        return model.reviews[index].author ?? ""
    }
    
    func getReview(at index: Int) -> String {
        return model.reviews[index].content ?? ""
    }
    
    func willDisplayCell(at index: Int) {
        if model.allowRequestNextPage, index == getNumberOfReviews() - 1, model.reviews.count < model.totalElements {
            model.allowRequestNextPage = false
            let prevPage = model.page
            model.page += 1
            getReviewsMovie(appendResult: true) { [weak self] error in
                self?.model.allowRequestNextPage = true
                if error != nil {
                    self?.model.page = prevPage
                }
            }
        }
    }
    
}
