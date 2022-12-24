//
//  ReviewItemTableCell.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit

class ReviewItemTableCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    private func setupView() {
        selectionStyle = .none
    }
    
    func bind(name: String, review: String) {
        nameLabel.text = name
        reviewLabel.text = review
    }
    
}
