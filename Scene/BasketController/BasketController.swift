//
//  BasketController.swift
//  E-Commerce
//
//  Created by Fatih on 23.02.2024.
//

import Foundation
import UIKit

class BasketController : UIViewController {
    
    var basketProducts: [Int] = []
    
    
    private let basketCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWith: CGFloat = collectionView.frame.width - 50
        let cellHeight: CGFloat = 180
        return .init(width: cellWith, height: cellHeight)
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
