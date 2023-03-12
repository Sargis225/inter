//
//  ProfileTableViewCell.swift
//  inter
//
//  Created by Saqo on 17.03.23.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var rowImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var balanceLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
}
