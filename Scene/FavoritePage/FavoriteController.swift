//
//  FavoriteController.swift
//  E-Commerce
//
//  Created by Fatih on 15.02.2024.
//

import Foundation
import UIKit
import SwipeCellKit


class FavoriteController: UIViewController {

    var favoriteProducts: [Int] = []
    var productDetailService: ProductDetailServiceProtocol = ProductDetailService()
    var products: [Product] = []
    private let favoriteCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        return collectionView
    }()
    
    private let favoriteTextField: UITextField = {
        let textField = UITextField()
        let imageIcon = UIImageView()
        imageIcon.image = UIImage(named: "search")
        imageIcon.tintColor = .darkGray
        let contentView = UIView()
        contentView.addSubview(imageIcon)
        contentView.frame = CGRect(x: 0, y: 0, width: (UIImage(named: "search")?.size.width)!, height: (UIImage(named: "search")?.size.height)!)
        imageIcon.frame = CGRect(x: 0, y: 0, width: (UIImage(named: "search")?.size.width)!, height: (UIImage(named: "search")?.size.height)!)
        textField.leftView = contentView
        textField.leftViewMode = .always
        textField.clearButtonMode = .whileEditing
        textField.borderStyle = .line
        textField.placeholder = "Search..."
        textField.backgroundColor = .white
        textField.font = .systemFont(ofSize: 15, weight: .light)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        delegateSetup()
        registerSetup()
        favoritTextField()
        favoriCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchSavedProducts()
    }
    
    func fetchSavedProducts() {
        FirebaseManager.shared.fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                let savedProducts = userDocument.userFovoriteProducts
                self.favoriteProducts = savedProducts
                DispatchQueue.main.async {
                    self.favoriteCollectionView.reloadData()
                }
            case .failure(let failure):
                break
            }
        }
    }
    
    func registerSetup() {
        favoriteCollectionView.register(FavoritePageCustomCell.self, forCellWithReuseIdentifier: FavoritePageCustomCell.identifier)
        
    }
    
    func delegateSetup() {
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteTextField.delegate = self
    }
    
}

//MARK: - Configure CollectionView

extension FavoriteController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return favoriteProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = favoriteCollectionView.dequeueReusableCell(withReuseIdentifier: FavoritePageCustomCell.identifier, for: indexPath) as! FavoritePageCustomCell
        let product = favoriteProducts[indexPath.item]
        cell.configure(id: product)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 70
        let cellHight: CGFloat = 180
        return(.init(width: cellWidth, height: cellHight))
    }
}

//MARK: - SwipeCell
extension FavoriteController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .default, title: "DELETE") { action, indexPath in
            guard let userID = FirebaseManager.shared.userID else  { return }
           
            self.productDetailService.getProductsDetail(id: self.favoriteProducts[indexPath.item]) { product, error in
                if let error = error {
                    fatalError()
                    
                } else {
                    
                    FirebaseManager.shared.updateFavoriteProduct(userID: userID, product: product!, willAdd: false) { result in
                        switch result {
                        case .success(_):
                            self.favoriteProducts.remove(at: indexPath.item)
                            DispatchQueue.main.async {
                                self.favoriteCollectionView.deleteItems(at: [indexPath])
                            }
                        case .failure(let failure):
                            print(failure.localizedDescription)
                        }
                    }
                    
                }
            }
            
        }
        
        deleteAction.image = UIImage(named: "bin")
        return [deleteAction]
    }
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
            var options = SwipeOptions()
            options.expansionStyle = .fill
            options.transitionStyle = .reveal
            options.backgroundColor = .bg
            
            return options
        }
    
}

//MARK: - TextField Delegate
extension FavoriteController: UITextFieldDelegate {
    
    
    
}


//MARK: - Configure Constrains

extension FavoriteController {
    
    func favoriCollectionView() {
        view.addSubview(favoriteCollectionView)
        NSLayoutConstraint.activate([
            favoriteCollectionView.topAnchor.constraint(equalTo: favoriteTextField.bottomAnchor,constant: 10),
            favoriteCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            favoriteCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func favoritTextField() {
        view.addSubview(favoriteTextField)
        NSLayoutConstraint.activate([
            favoriteTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            favoriteTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            favoriteTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}
