//
//  UserViewController.swift
//  inter
//
//  Created by Saqo on 17.03.23.
//

import UIKit

class UserViewController: UITabBarController, UITabBarControllerDelegate {
    var viewModel : UserViewModel!
    @IBOutlet weak var userTabBar: UITabBar!
     var allViewControllers: [UIViewController]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}
