//
//  ListReviewsView.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit

class ListReviewsView: UIViewController {
    
    let viewModel: IListReviewsViewModel
    
    init(viewModel: IListReviewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "ListReviewsView", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet weak var reviewTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigation()
        viewModel.viewWillAppear()
    }
    
    private func setupNavigation() {
        self.navigationController?.showBarIfNecessary()
    }
    
    private func setupTableView() {
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.estimatedRowHeight = 200
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register([ReviewItemTableCell.self])
    }

}

extension ListReviewsView: IListMovieView {
    func reloadView() {
        
    }
}

extension ListReviewsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

extension ListReviewsView: UITableViewDelegate {
    
}
