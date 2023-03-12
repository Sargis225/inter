//
//  ProductCollectionViewCell.swift
//  inter
//
//  Created by Saqo on 18.03.23.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var productsImage: UIImageView!
    
    @IBOutlet weak var saleImageView: UIImageView!
    
    @IBOutlet weak var categiryNameLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var likedImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categiryNameLabel.layer.masksToBounds = true
        categiryNameLabel.layer.cornerRadius = 20
        
    }
}
