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
        self.title = "Reviews"
    }
    
    private func setupTableView() {
        reviewTableView.rowHeight = UITableView.automaticDimension
        reviewTableView.estimatedRowHeight = 200
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.register([ReviewItemTableCell.self])
    }

}

extension ListReviewsView: IListReviewsView {
    func reloadView() {
        DispatchQueue.main.async { [unowned self] in
            self.reviewTableView.reloadData()
        }
    }
}

extension ListReviewsView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfReviews()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell: ReviewItemTableCell = tableView.dequeueReusableCell() {
            
            cell.bind(name: viewModel.getName(at: indexPath.row),
                      review: viewModel.getReview(at: indexPath.row))
            
            return cell
        }
        return UITableViewCell()
    }
}

extension ListReviewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel.willDisplayCell(at: indexPath.row)
    }
}
