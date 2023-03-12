//
//  AppCordinator.swift
//  inter
//
//  Created by Saqo on 14.03.23.
//

import Foundation
import UIKit

class AppCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var children: [Coordinator] = []
    var navigationController: UINavigationController
    
    
    init(navCon : UINavigationController) {
        self.navigationController = navCon
    }
    
    func start() {
        print("App Coordinator start")
        goToRegisterPage()
//        goToProfilePage()
    }
    
    let storyboard = UIStoryboard.init(name: "Main", bundle: .main)
    
        func goToLoginPage(){
             // Instantiate LoginViewController
             let loginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
             // Instantiate LoginViewModel
             let loginViewModel = LoginViewModel.init()
             // Set the Coordinator to the ViewModel
             loginViewModel.appCoordinator = self
             // Set the ViewModel to ViewController
             loginViewController.viewModel = loginViewModel
             // Push it.
            navigationController.pushViewController(loginViewController, animated: true)
        }
    
        func goToRegisterPage(){
            let registerViewController = storyboard.instantiateViewController(withIdentifier: "RegisterViewController") as! SignInViewController
            let registerViewModel = RegisterViewModel.init()
            registerViewModel.appCoordinator = self
            registerViewController.viewModel = registerViewModel
             navigationController.pushViewController(registerViewController, animated: true)
        }
    
    func goToProfilePage() {
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
//        profileViewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        let profileViewModel = ProfileViewModell.init()
        profileViewModel.appCoordinator = self
        profileViewController.profileViewModel = profileViewModel
        
        navigationController.pushViewController(profileViewController, animated: true)
    }
    
    func goToUserPage() {
        let userViewController = storyboard.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
        let userViewModel = UserViewModel.init()
        userViewModel.appCoordinator = self
        userViewController.viewModel = userViewModel
        
        navigationController.pushViewController(userViewController, animated: true)
        
    }
    
    func goToHomePage() {
        let homePageViewController = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        let homePageViewModel = HomePageViewModel.init()
        homePageViewModel.appCoordinator = self
        homePageViewController.viewModel = homePageViewModel
        
        navigationController.pushViewController(homePageViewController, animated: true)
        
    }
    
}


