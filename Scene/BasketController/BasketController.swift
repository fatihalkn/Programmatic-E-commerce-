//
//  BasketController.swift
//  E-Commerce
//
//  Created by Fatih on 23.02.2024.
//

import Foundation
import UIKit
import SwipeCellKit

class BasketController : UIViewController {
    var productDetailService: ProductDetailServiceProtocol = ProductDetailService()
    var basketProducts: [Int] = []
    
    
    private let basketCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .bg
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(basketCollectionView)
        basketCollectionViewConstrain()
        setupDelegate()
        setupRegister()
        fetchBasketProducts()
        view.backgroundColor = .white
       
        
    }
    
    
    func fetchBasketProducts() {
        FirebaseManager.shared.fetchUserDocument { result in
            switch result {
            case .success(let userDociment):
                self.basketProducts = userDociment.userBasketeProducts
                DispatchQueue.main.async {
                    self.basketCollectionView.reloadData()
                }
            case .failure(let failure):
                print("asdasfererer")
            }
        }
    }
    
    func setupRegister() {
        basketCollectionView.register(BasketPageCell.self, forCellWithReuseIdentifier: BasketPageCell.identifier)
        
    }
    
    func setupDelegate() {
        basketCollectionView.dataSource = self
        basketCollectionView.delegate = self
    }
    
    
}


extension BasketController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return basketProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = basketCollectionView.dequeueReusableCell(withReuseIdentifier: BasketPageCell.identifier, for: indexPath) as! BasketPageCell
        let basketProdcuts = basketProducts[indexPath.item]
        cell.configure(id: basketProdcuts)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith: CGFloat = collectionView.frame.width - 50
        let cellHeight: CGFloat = 180
        return .init(width: cellWith, height: cellHeight)
    }
    
    
}


extension BasketController: SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeCellKit.SwipeActionsOrientation) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "DELETE") { action, indexPath in
            guard let userID = FirebaseManager.shared.userID else  { return }
            self.showSucceed(text: "", interaction: false, delay: 1)
            self.productDetailService.getProductsDetail(id: self.basketProducts[indexPath.item] ) { product, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                } else {
                    
                    FirebaseManager.shared.updateBasketProduct(userID: userID, product: product!, willAdd: false) { result in
                        switch result {
                        case .success(_):
                            self.basketProducts.remove(at: indexPath.item)
                            DispatchQueue.main.async {
                                self.basketCollectionView.deleteItems(at: [indexPath])
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
}


extension BasketController {
    func basketCollectionViewConstrain() {
        NSLayoutConstraint.activate([
            basketCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            basketCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            basketCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            basketCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
