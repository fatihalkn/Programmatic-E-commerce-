//
//  CategoryListViewController.swift
//  E-Commerce
//
//  Created by Fatih on 16.02.2024.
//

import Foundation
import UIKit

class CategoryListViewController: UIViewController {

    var category: Category?
    var categoryProducts: [Product] = []
    
    private let categoryService: CategoryItemsServiceProtocol = CategoryItemsService()
    
    private let listCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setupRegister()
        setupDelegate()
        fetchSelectedCategory()
    }
    
    func fetchSelectedCategory() {
        guard let category else { return }
        switch category {
        case .electronics:
            categoryService.getElectronicsProducts { products, error in
                if let error {
                    return
                }
                self.categoryProducts = products
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()
                }
            }
        case .jewelery:
            categoryService.getJeweleryProducts { products, error in
                if error != nil {
                    return
                }
                self.categoryProducts = products
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()

                }
            }
        case .menSClothing:
            categoryService.getMensclothingProducts { products, error in
                if error != nil {
                    return
                }
                self.categoryProducts = products
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()

                }
            }
        case .womenSClothing:
            categoryService.getWomensclothingProducts { products, error  in
                if error != nil {
                    return
                }
                self.categoryProducts = products
                DispatchQueue.main.async {
                    self.listCollectionView.reloadData()

                }
            }
        }
       
    }
    
    func setupRegister() {
        listCollectionView.register(HomePageCustomCell.self, forCellWithReuseIdentifier: HomePageCustomCell.identifier)
        
    }
    
    func setupDelegate() {
        listCollectionView.dataSource = self
        listCollectionView.delegate = self
        
    }
    
    
    
}

//MARK: - Configure CollectionView
extension CategoryListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = listCollectionView.dequeueReusableCell(withReuseIdentifier: HomePageCustomCell.identifier, for: indexPath) as! HomePageCustomCell
        let product = categoryProducts[indexPath.item]
        cell.configure(data: product)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = (collectionView.frame.width - (20 + 20 + 20 )) / 2
        let cellHight: CGFloat = 250
        return(.init(width: cellWidth, height: cellHight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedProductID = categoryProducts[indexPath.item].id {
            let productDetail = ProductsDetail()
            productDetail.productID = selectedProductID
            navigationController?.pushViewController(productDetail, animated: true)
            
            if let selectedProductTitle = categoryProducts[indexPath.item].title {
                productDetail.title = selectedProductTitle
            } else {
                print("Ürün İsmi yazılmadı")
            }
            
        } else {
            print("Detay Sayfasına gidilmedi")

        }
    }
    
}


//MARK: - UI Constraints
extension CategoryListViewController {
    
    func configureCollectionView() {
        view.backgroundColor = .white
        view.addSubview(listCollectionView)
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            listCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        
    }
}
