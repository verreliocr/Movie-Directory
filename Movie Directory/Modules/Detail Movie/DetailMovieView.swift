//
//  DetailMovieView.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit
import WebKit

class DetailMovieView: UIViewController {
    
    let viewModel: IDetailMovieViewModel
    
    init(viewModel: IDetailMovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "DetailMovieView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UIButton!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webViewLoading: UIView!
    @IBOutlet weak var reviewsButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension DetailMovieView: IDetailMovieView {
    func reloadView() {
        
    }
}
