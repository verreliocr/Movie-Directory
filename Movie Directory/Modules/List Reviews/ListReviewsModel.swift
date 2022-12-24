//
//  ListReviewsModel.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import Foundation

class ListReviewsModel {
    var movieId: Int = 0
    var page: Int = 1
    var totalPages: Int = 0
    var totalElements: Int = 0
    var allowRequestNextPage: Bool = true
    var reviews: [ReviewObject] = []
}
