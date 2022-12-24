//
//  MovieItemCollectionCell.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit

class MovieItemCollectionCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(imageUrl: URL, title: String, rate: Double, overview: String) {
        posterImageView.setImage(url: imageUrl, placeholder: nil)
        titleLabel.text = title
    }

}
