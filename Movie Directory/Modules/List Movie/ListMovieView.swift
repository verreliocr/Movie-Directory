//
//  ListMovieView.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit

class ListMovieView: UIViewController {
    
    let viewModel: IListMoviesViewModel
    
    init(viewModel: IListMoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ListMovieView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "Movie Directory"
        setupNavigation()
        viewModel.viewWillAppear()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
    }
    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.register([MovieItemCollectionCell.self])
    }

}

extension ListMovieView: IListMovieView {
    func reloadView() {
        DispatchQueue.main.async { [unowned self] in
            self.movieCollectionView.reloadData()
        }
    }
}

extension ListMovieView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

extension ListMovieView: UICollectionViewDelegate {
    
}
