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
        setupView()
        setupAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        viewModel.viewWillAppear()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        webView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let value = webView.estimatedProgress
            let progress = Float(value)
            if progress == 1 {
                self.webViewLoading.isHidden = true
            } else {
                self.webViewLoading.isHidden = false
            }
        }
    }
    
    private func setupNavigation() {
        self.title = "Detail Movie"
        self.navigationController?.showBarIfNecessary()
    }
    
    private func setupView() {
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 88, right: 0)
    }
    
    private func setupAction() {
        reviewsButton.addAction { [unowned self] in
            self.viewModel.didSelectReviews()
        }
    }

}

extension DetailMovieView: IDetailMovieView {
    func reloadView() {
        if let url = viewModel.getImageURL() {
            posterImageView.setImage(url: url, placeholder: nil)
        }
        
        titleLabel.text = viewModel.getTitleMovie()
        ratingLabel.setTitle(viewModel.getRate(), for: .normal)
        genreLabel.text = viewModel.getGenre()
        releaseDateLabel.text = viewModel.getReleaseDate()
        overviewLabel.text = viewModel.getOverview()
        
        DispatchQueue.main.async { [unowned self] in
            if let url = URL(string: "https://www.youtube.com/embed/\(viewModel.getYoutubeKey())") {
                webView.load(URLRequest(url: url))
                webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
                webView.isHidden = false
            }else{
                webView.isHidden = true
            }
        }
        
    }
}
