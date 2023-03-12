//
//  ProfileViewController.swift
//  inter
//
//  Created by Saqo on 14.03.23.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var profileViewModel = ProfileViewModell.init()
    let fontName =  "Montserrat-Regular"
    let imagePicker = UIImagePickerController()
    @IBOutlet weak var profileTabBarItem: UITabBarItem!
    @IBOutlet weak var profileTableView: UITableView!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    
    
    let titleTableViewRow:[String] = ["Trade store", "Payment method", "Balance", "Trade history", "Restore Purchase", "Help", "Log out"]
    let iconRow:[UIImage] = [UIImage(named: "book")!,UIImage(named: "book")!,UIImage(named: "book")!,UIImage(named: "book")!, UIImage(named: "restore")!,UIImage(named: "help")!,UIImage(named: "logOut")!]
    
    let thereIsOrNot = [true,true,false,true,true,false,false]
    @IBOutlet weak var uploadItemButton: UIButton! {
        didSet {
            buttonSetup(button: uploadItemButton, name: "Upload item")
        }
    }
    
    
    @IBAction func changePhotopressed(_ sender: UIButton) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    internal func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.userImageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        userImageView.layer.masksToBounds = true
        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
        userImageView.clipsToBounds = true
        profileTableView.delegate = self
        profileTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileViewModel.appCoordinator = AppCoordinator(navCon: self.navigationController!)
    }
    
    func setNavigationBar() {
        let screenSize: CGRect = UIScreen.main.bounds
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 44, width: screenSize.width, height: 44))
        //        navBar.arappearance().backgroundColor = .green
        navBar.barTintColor = UIColor.white
        navBar.shadowImage = UIImage()
        let navItem = UINavigationItem(title: "Profile")
        let buttonImage = UIImage(systemName: "arrow.backward")
        let backButtonItem = UIBarButtonItem(image: buttonImage, style: .plain, target: nil, action: #selector(backButtonPressed))
        backButtonItem.tintColor = .black
        backButtonItem.customView?.backgroundColor = .black
        navItem.leftBarButtonItem = backButtonItem
        navBar.setItems([navItem], animated: false)
        self.view.addSubview(navBar)
    }
    
    @objc func backButtonPressed() { // remove @objc for Swift 3
        print("Pressed")
    }
    
    func buttonSetup(button: UIButton, name:String) {
        button.backgroundColor = UIColor(red: 78/225, green: 85/225, blue: 215/225, alpha: 1)
        button.setTitle(name, for: .normal)
        button.titleLabel?.font = UIFont(name: fontName, size: 14)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 15
    }
    
    
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return titleTableViewRow.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCellIdent") as! ProfileTableViewCell
        cell.nameLable.text = titleTableViewRow[indexPath.section]
        cell.iconImageView.image = iconRow[indexPath.section]
        switch thereIsOrNot[indexPath.section] {
        case true:
            //            cell.rowImageView.image = UIImage(systemName: "chevron.forward")
            cell.balanceLable.isHidden = true
        case false:
            cell.rowImageView.isHidden = true
        }
        
        switch titleTableViewRow[indexPath.section] {
        case "Help":
            cell.balanceLable.isHidden = true
        case "Log out":
            cell.balanceLable.isHidden = true
        default:
            print("ok")
        }
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch titleTableViewRow[indexPath.section] {
        case "Log out":
            profileViewModel.appCoordinator.goToRegisterPage()
        default:
            print("\(titleTableViewRow[indexPath.section]) pressed")
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 3
    }
    
}
