//
//  StandartsTextField.swift
//  inter
//
//  Created by Saqo on 12.03.23.
//

import UIKit

class StandartsTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       setup()
    }
    
    func setup() {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 15
        self.clipsToBounds = true
        

        /*
        let border = CALayer()
                let width = CGFloat(2.0)
            border.borderColor = UIColor.darkGray.cgColor
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = width
            self.layer.addSublayer(border)
        */
//            self.layer.masksToBounds = true
        }

}
