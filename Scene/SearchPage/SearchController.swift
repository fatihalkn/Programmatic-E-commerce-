//
//  SearchController.swift
//  E-Commerce
//
//  Created by Fatih on 15.02.2024.
//

import Foundation
import UIKit


class SearchController: UIViewController {
    
    var searchProducts: [Product] = []
    var originalProducts: [Product] = []
    var searhProductsService: CategoryItemsServiceProtocol = CategoryItemsService()
    
    private let searchCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private let searhTextField: UITextField = {
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
        setupDelegate()
        setupRegister()
        setupConstrains()
        fetchAllProducts()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    func textFieldRadius() {
        searhTextField.layer.cornerRadius = searhTextField.frame.height / 2
        searhTextField.layer.masksToBounds = true
    }
    
    func fetchAllProducts() {
        searhProductsService.getAllCategoryProducts { product, error in
            if let error = error {
                return
            } else {
                self.searchProducts = product
                self.originalProducts = product
                DispatchQueue.main.async {
                    self.searchCollectionView.reloadData()
                }
            }
        }
    }
    
   
    
    
    func setupRegister() {
        searchCollectionView.register(SearchPageCustomCell.self, forCellWithReuseIdentifier: SearchPageCustomCell.identifier)
    }
    
    func setupDelegate() {
        searchCollectionView.dataSource = self
        searchCollectionView.delegate = self
        searhTextField.delegate = self
    }
}
 

//MARK: - CollectionView Delegate - Datasource
extension SearchController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchProducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: SearchPageCustomCell.identifier, for: indexPath) as! SearchPageCustomCell
        let products = searchProducts[indexPath.item]
        cell.configure(data: products)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth: CGFloat = collectionView.frame.width - 50
        let cellHight: CGFloat = 130
        return(.init(width: cellWidth, height: cellHight))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selecetedProduct = searchProducts[indexPath.item].id
        let detailVc = ProductsDetail()
        detailVc.productID = selecetedProduct
        navigationController?.pushViewController(detailVc, animated: true)
    }
    
    
}



//MARK: - TextField Delegate
extension SearchController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let textFieldText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        let filteredProducts = originalProducts.filter { $0.title!.lowercased().contains(textFieldText.lowercased())}
        
        if textFieldText.isEmpty {
            searchProducts = originalProducts
        } else {
            searchProducts = filteredProducts
        }
        
        searchCollectionView.reloadData()
        return true
    }
    
}


//MARK: - Configure Constrains
extension SearchController {
    
    func setupConstrains() {
        view.addSubview(searchCollectionView)
        view.addSubview(searhTextField)
        searchCollectionViewConstrain()
        searchTextFieldConstrain()
    }
    
    func searchCollectionViewConstrain() {
        NSLayoutConstraint.activate([
            searchCollectionView.topAnchor.constraint(equalTo: searhTextField.bottomAnchor,constant: 10),
            searchCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            searchCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    func searchTextFieldConstrain() {
        NSLayoutConstraint.activate([
            searhTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searhTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            searhTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -20),
            searhTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}


