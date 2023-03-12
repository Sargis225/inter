//
//  SignInViewModel.swift
//  inter
//
//  Created by Saqo on 14.03.23.
//

import Foundation



class RegisterViewModel {
    weak var appCoordinator : AppCoordinator!
    
    func goToLogin(){
        appCoordinator.goToLoginPage()
    }
    
    
    
}
