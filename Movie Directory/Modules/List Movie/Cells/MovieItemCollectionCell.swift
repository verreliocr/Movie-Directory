//
//  MovieItemCollectionCell.swift
//  Movie Directory
//
//  Created by Verrelio C. Rizky on 24/12/22.
//

import UIKit

class MovieItemCollectionCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func bind(imageUrl: URL) {
        posterImageView.setImage(url: imageUrl, placeholder: nil)
    }

}
