//
//  ViewController.swift
//  inter
//
//  Created by Saqo on 12.03.23.
//

import UIKit
import CoreData


class SignInViewController: UIViewController {
    
    var viewModel : RegisterViewModel!
    let fontName =  "Montserrat-Regular"
    var user: [User] = []
    let App = UIApplication.shared.delegate as! AppDelegate
    
    
    
    @IBOutlet weak var firstNamTF: StandartsTextField! {
        didSet {
            placeHolderTFSetup(TF: firstNamTF, namePH: "First name")
            
        }
    }
    
    @IBOutlet weak var lastNameTF: StandartsTextField! {
        didSet {
            placeHolderTFSetup(TF: lastNameTF, namePH: "Last name")
        }
    }
    @IBOutlet weak var emailTF: StandartsTextField!{
        didSet {
            placeHolderTFSetup(TF: emailTF, namePH: "Email")
        }
    }
    
    @IBOutlet weak var signInButton: UIButton! {
        didSet {
            buttonSetup(button: signInButton, name: "Sign in")
        }
    }
    
    
    
    @IBAction func signInButtonPressed(_ sender: UIButton) {
        
        guard let firstName = firstNamTF.text,
              let lastName = lastNameTF.text,
              let email = emailTF.text else {return}
        
        guard firstName != "",
              lastName != "",
              email != "" else {return}
        
        saveUser(with: firstName, lastName: lastName, email: email)
        viewModel.appCoordinator.goToUserPage()
    }
    
    
    
    @IBAction func logInButtonPressed(_ sender: UIButton) {
        viewModel.appCoordinator.goToLoginPage()
        
    }
    
    
    private func saveUser(with firstName: String, lastName: String, email: String) {
        if check(user: user, email: email) {
            if  checkEmail(email: email) {
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                guard let entity = NSEntityDescription.entity(forEntityName: "User", in: context) else {return}
                let userObject = User(entity: entity, insertInto: context)
                userObject.firstName = firstName.trimmingCharacters(in: .whitespaces)
                userObject.lastName = lastName.trimmingCharacters(in: .whitespaces)
                userObject.email = email.trimmingCharacters(in: .whitespaces)
                
                do {
                    try context.save()
                    user.append(userObject)
                    
                } catch let error as NSError {
                    
                    print(error.localizedDescription)
                }
            }
        } else {
            haveMailProfile()
        }
    }
    
    func check(user: [User], email: String) -> Bool {
        for i in user {
            if i.email == email {
                
                haveMailProfile()
                print("have")
                return false
            }
        }
        return true
    }
    
    
    func haveMailProfile () {
        let alertContoller = UIAlertController(title: "This email is already registered", message: "Can you login?", preferredStyle: .alert)
        let alertActionOk = UIAlertAction(title: "Yes", style: .default) {_ in
            self.viewModel.appCoordinator.goToLoginPage()
        }
        let alertActionCanel = UIAlertAction(title: "No", style: .cancel)
        alertContoller.addAction(alertActionOk)
        alertContoller.addAction(alertActionCanel)
        present(alertContoller, animated: true)
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
    
    func checkEmail(email: String) -> Bool {
        if !email.contains("@mail.ru") {
            let alertContoller = UIAlertController(title: "\(email) – неверно", message: "\(email)@mail.ru – верно?", preferredStyle: .alert)
            let alertActionOk = UIAlertAction(title: "верно", style: .default) {_ in
                self.emailTF.text = "\(email)@mail.ru"
            }
            let alertActionCanel = UIAlertAction(title: "неверно", style: .cancel)
            alertContoller.addAction(alertActionOk)
            alertContoller.addAction(alertActionCanel)
            present(alertContoller, animated: true)
            return false
        } else {
            return true
        }
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lastNameTF.text = ""
        firstNamTF.text = ""
        emailTF.text = ""
        getUsers()
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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
        TF.attributedPlaceholder = redPlaceholderText
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y =  self.view.frame.origin.y - (signInButton.frame.height + 10)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

