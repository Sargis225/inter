//
//  HomePageViewController.swift
//  inter
//
//  Created by Saqo on 17.03.23.
//

import UIKit
import CoreData
var categoryAndProductsImage:[CategoryAndProductImage] = [
    CategoryAndProductImage(category: "Latest", productsImage: [UIImage(named: "PhonesProducts")!,UIImage(named: "GamesProducts")!,UIImage(named: "GamesProductsTwo")!]),
    CategoryAndProductImage(category: "Flash Sale", productsImage: [UIImage(named: "New balance sneakers black")!,UIImage(named: "New balance sneakers white")!]),
    CategoryAndProductImage(category: "Latest", productsImage: [UIImage(named: "PhonesProducts")!,UIImage(named: "GamesProducts")!,UIImage(named: "GamesProductsTwo")!])
]


class HomePageViewController: UIViewController {
    

    var viewModel = HomePageViewModel.init()
    @IBOutlet weak var typeInterestingCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    
    @IBAction func goToProfilePressed(_ sender: UIButton) {
        viewModel.appCoordinator.goToProfilePage()
    }
    
    let cellIdent = "typrInteresCell"
    let categoryCellIdent = "categoryCellIdent"
    let typeInteres:[String] = ["Phones", "Headphones", "Games", "Cars", "Furniture", "Kids"]
    let sectionInserts = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 5)
    var rowHeight:[CGFloat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        typeInterestingCollectionView.delegate = self
        typeInterestingCollectionView.dataSource = self
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.sectionHeaderTopPadding = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.appCoordinator = AppCoordinator(navCon: self.navigationController!)
        
    }
    
    
    
    
}

extension HomePageViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return typeInteres.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdent, for: indexPath) as! TypeInteresCollectionViewCell
        cell.typeInteresNameLabel.text = typeInteres[indexPath.item]
        cell.typeInteresImage.image = UIImage(named: typeInteres[indexPath.item])
        return cell
    }
    
    // ays methodov talis asum enq te inchqan lini nra heravorutyun@ top-ic buttomic leadongic u trailingica
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInserts
    }
    
//     toxeri meji heravorutyun@ asum enq ays methodov
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
}
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categoryAndProductsImage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryCellIdent, for: indexPath) as! CategoryTableViewCell
        cell.categoriesLabel.text = categoryAndProductsImage[indexPath.section].category
        cell.productsCollectionView.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section{
        case 0:
            return 200
        case 1:
            return 270
        default:
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
}





















//func setNavigationBar() {
//    let screenSize: CGRect = UIScreen.main.bounds
//    let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: screenSize.width, height: 40))
////        navBar.arappearance().backgroundColor = .green
//    navBar.barTintColor = UIColor.white
//    navBar.shadowImage = UIImage()
//    let navItem = UINavigationItem(title: "Trade by bata")
//    let leftButtonImage = UIImage(systemName: "text.justify")
//    let leftBackButtonItem = UIBarButtonItem(image: leftButtonImage, style: .plain, target: nil, action: #selector(manuButtonPressed))
//    leftBackButtonItem.tintColor = .black
//    navItem.leftBarButtonItem = leftBackButtonItem
//
//    let rightButtonImage = UIImage(named: "ProfilePhoto")
//    let rightButtonItem = UIBarButtonItem(image: rightButtonImage, style: .done, target: nil, action: #selector(goProfileButtonPressed))
//    rightButtonItem.setBackgroundImage(rightButtonImage, for: .normal, barMetrics: .default)
//    rightButtonItem.tintColor = .clear
//    navItem.rightBarButtonItem = rightButtonItem
//
//    navBar.setItems([navItem], animated: false)
//    self.view.addSubview(navBar)
//}
//
//@objc func manuButtonPressed() { // remove @objc for Swift 3
//    print("Pressed")
//}
//
//@objc func goProfileButtonPressed() { // remove @objc for Swift 3
//    print("PressedPhoto")
//}
