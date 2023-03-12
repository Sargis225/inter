//
//  LoginViewModel.swift
//  inter
//
//  Created by Saqo on 14.03.23.
//

import Foundation

class LoginViewModel {
    weak var appCoordinator : AppCoordinator!
    
    func goToRegister(){
        appCoordinator.goToRegisterPage()
    }
    func goToProfile(userName:String, password:String) {
        
    }
    
    
    
}
