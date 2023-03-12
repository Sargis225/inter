//
//  CategoryTableViewCell.swift
//  inter
//
//  Created by Saqo on 18.03.23.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    let productsCollectionViewCellIdent = "productsCollectionViewCellIdent"
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var categoriesLabel: UILabel!
    let categoriesName = ["Phones","Games", "Games"]
    let productName = ["Samsung S10","Play Station 5 console", "Play Station 5 console"]
    let prices = ["$ 180,000","$ 90,000", "$ 95,000"]

    override func awakeFromNib() {
        super.awakeFromNib()
        
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
extension CategoryTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryAndProductsImage[productsCollectionView.tag].productsImage.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: productsCollectionViewCellIdent, for: indexPath) as! ProductCollectionViewCell
        cell.productsImage.image = categoryAndProductsImage[productsCollectionView.tag].productsImage[indexPath.item]
        cell.categiryNameLabel.layer.masksToBounds = true
        cell.categiryNameLabel.layer.cornerRadius = 3
        switch collectionView.tag {
        case 0:
            cell.iconImageView.isHidden = true
            cell.likedImageView.isHidden = true
            cell.saleImageView.isHidden = true
            cell.categiryNameLabel.text = categoriesName[indexPath.row]
            cell.priceLabel.text = prices[indexPath.row]
            cell.productNameLabel.text = productName[indexPath.row]
            
        case 2:
            cell.iconImageView.isHidden = true
            cell.likedImageView.isHidden = true
            cell.saleImageView.isHidden = true
            cell.categiryNameLabel.text = categoriesName[indexPath.row]
            cell.priceLabel.text = prices[indexPath.row]
            cell.productNameLabel.text = productName[indexPath.row]
        case 1:
            if indexPath.row == 0 {
                cell.priceLabel.text = "$ 33,00"
            } else {
                cell.priceLabel.text = "$ 22,50"
            }
           
            cell.productNameLabel.text = "New balance sneakers"
            cell.categiryNameLabel.text = "Kids"
        default:
           print("Ok")
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
