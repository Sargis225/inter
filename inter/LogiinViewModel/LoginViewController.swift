//
//  LoginViewController.swift
//  inter
//
//  Created by Saqo on 13.03.23.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    var viewModel : LoginViewModel!
    var user:[User] = []
    let password = "pasUser"
    var result = NSArray()
    let fontName =  "Montserrat-Regular"
    
    @IBOutlet weak var firstNameTF: StandartsTextField! {
        didSet {
            placeHolderTFSetup(TF: firstNameTF, namePH: "First name")
        }
    }
    
    @IBOutlet weak var passWordTF: StandartsTextField! {
        didSet {
            placeHolderTFSetup(TF: passWordTF, namePH: "Password")

        }

    }
    
    
    @IBOutlet weak var logInButton: UIButton! {
        didSet {
            buttonSetup(button: logInButton, name: "Login")
        }
    }
    
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        
        if firstNameTF.text == "" || passWordTF.text == ""
        {
            let alert = UIAlertController(title: "Information", message: "Please enter all the fields", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alert.addAction(ok)
            alert.addAction(cancel)
            
            self.present(alert, animated: true)
        } else {
            chackUser(with: firstNameTF.text!, password: passWordTF.text!)
        }
    }
    
    
    func getUsers() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        do {
            user = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
    
    func chackUser(with firstName: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        
        let predicate = NSPredicate(format: "firstName = %@", firstName)
        
        fetchRequest.predicate = predicate
        do {
            result = try context.fetch(fetchRequest) as NSArray

            if result.count > 0 {
                let objectentity = result.firstObject as! User
            
                if objectentity.firstName == firstName && password == self.password {
                    viewModel.appCoordinator.goToUserPage()
                    print("Login Succesfully")
                }
                else {
                    wrongPasOrUserName()
                    print("Wrong username or password !!!")
                }
            } else {
                wrongPasOrUserName()
                print("Wrong username or password !!!")
            }
        }
        
        catch {
            let error = error as NSError
            print("error", error.localizedDescription)
        }
    }
    
    
    func wrongPasOrUserName() {
        let alert = UIAlertController(title: "Information", message: "Wrong username or password", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let goSignIn = UIAlertAction(title: "Sign in", style: .default){_ in
            self.viewModel.appCoordinator.goToRegisterPage()
        }
        alert.addAction(goSignIn)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUsers()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        for i in user {
            guard let firstName = i.firstName else {return}
            print(print(firstName))
            print("Exemple password \(password)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTF.text = ""
        passWordTF.text = ""
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        // Do any additional setup after loading the view.
    }
    
    func buttonSetup(button: UIButton, name:String) {
        button.backgroundColor = UIColor(red: 78/225, green: 85/225, blue: 215/225, alpha: 1)
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
    }
    
    func placeHolderTFSetup(TF: UITextField, namePH:String) {
        let font = UIFont(name: fontName, size: 11)!
        
        let redPlaceholderText = NSAttributedString(string: namePH,
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                                                                 NSAttributedString.Key.font: font ])
        TF.textAlignment = .center
        TF.attributedPlaceholder = redPlaceholderText
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y =  self.view.frame.origin.y - logInButton.frame.height
            }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

    

}
