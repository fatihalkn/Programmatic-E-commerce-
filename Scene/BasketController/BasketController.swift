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
    var basketProducts: [[String : Int]] = []
    var totalBasketPrice: Double = 0.0
    
    private let totalPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg
        view.layer.cornerRadius = 15
        view.layer.borderWidth = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let totalLabelPrice: UILabel = {
        let label = UILabel()
        label.text = "111111111111111$"
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let orderButton = CustomButtons(title: "Complete Order",
                                           titleColor: .white,
                                           font: .systemFont(ofSize: 17),
                                           backroundColor: .main)
    
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
        view.backgroundColor = .white
        view.addSubview(basketCollectionView)
        view.addSubview(totalPriceView)
        view.addSubview(totalLabelPrice)
        view.addSubview(orderButton)
        basketCollectionViewConstrain()
        totalPriceViewConstrain()
        totalLabelPriceConstrain()
        orderButtonConstrain()
        setupDelegate()
        setupRegister()
        calculateTotalBasketPrice()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBasketProducts()

        
    }
    
    
    func fetchBasketProducts() {
        FirebaseManager.shared.fetchUserDocument { result in
            switch result {
            case .success(let userDociment):
                self.basketProducts = userDociment.userBasketeProducts
                DispatchQueue.main.async {
                    self.basketCollectionView.reloadData()
                    self.calculateTotalBasketPrice()
                }
            case .failure(_):
                print("asdasfererer")
            }
        }
    }
    
    
    private func calculateTotalBasketPrice() {
        var totalPrice = 0.0
        let group = DispatchGroup() // DispatchGroup oluştur

        for productDict in basketProducts {
            if let productCount = productDict.values.first,
               let productID = Int(productDict.keys.first ?? "0") {
                group.enter() // DispatchGroup'a giriş yap
                getProductPrice(productID: productID) { productPrice in
                    totalPrice += Double(productCount) * productPrice
                    group.leave() // DispatchGroup'tan çıkış yap
                }
            }
        }

        group.notify(queue: .main) {
            // Tüm asenkron işlemler tamamlandığında bu blok çalışır
            self.totalLabelPrice.text = "\(totalPrice)$"
        }
    }


    
  
    
    func setupRadius() {
        orderButton.layer.cornerRadius = orderButton.frame.size.height / 2
        orderButton.layer.masksToBounds = true
        
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
        cell.configure(id: Int(basketProdcuts.keys.first ?? "0"))
        cell.delegate = self
        cell.basketPageCellDelegate = self
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
            self.productDetailService.getProductsDetail(id: Int(self.basketProducts[indexPath.item].keys.first ?? "0") ?? 0 ) { product, error in
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
            basketCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20), // Örnek olarak üst boşluk değeri artırıldı
            basketCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            basketCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            basketCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    
    func totalPriceViewConstrain() {
        NSLayoutConstraint.activate([
            totalPriceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150), // Örnek olarak yükseklik değeri artırıldı
            totalPriceView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            totalPriceView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            totalPriceView.heightAnchor.constraint(equalToConstant: 150) // Yükseklik değeri artırıldı
        ])
    }

    
    func totalLabelPriceConstrain() {
        NSLayoutConstraint.activate([
            totalLabelPrice.centerYAnchor.constraint(equalTo: totalPriceView.centerYAnchor),
            totalLabelPrice.leadingAnchor.constraint(equalTo: totalPriceView.leadingAnchor,constant: 20),
            totalLabelPrice.trailingAnchor.constraint(lessThanOrEqualTo: orderButton.leadingAnchor),
            
        ])
    }
    
    func orderButtonConstrain() {
        NSLayoutConstraint.activate([
            orderButton.centerYAnchor.constraint(equalTo: totalPriceView.centerYAnchor),
            orderButton.trailingAnchor.constraint(equalTo: totalPriceView.trailingAnchor,constant: -20),
            orderButton.heightAnchor.constraint(equalToConstant: 50),
            orderButton.leadingAnchor.constraint(equalTo: totalPriceView.centerXAnchor)
            
        ])
    }
}

//MARK: - BasketPageCellDelegate
extension BasketController: BasketPageCellDelegate {
    func productCountDidChange(productID: Int, productCount: Int) {
        let productIDString = "\(productID)"
        if let productIndex = basketProducts.firstIndex(where: { $0.keys.contains(productIDString)}) {
            basketProducts[productIndex][productIDString] = productCount

            var totalPrice = 0.0
            let group = DispatchGroup()

            basketProducts.forEach { productDict in
                if let productCount = productDict.values.first,
                   let productID = Int(productDict.keys.first ?? "0") {
                    group.enter()
                    getProductPrice(productID: productID) { productPrice in
                        totalPrice += Double(productCount) * productPrice
                        group.leave()
                    }
                }
            }

            group.notify(queue: .main) {
                self.totalLabelPrice.text = "\(totalPrice)$"
            }
        }
    }

    
    private func getProductPrice(productID: Int, completion: @escaping (Double) -> Void) {
        productDetailService.getProductsDetail(id: productID) { product, error in
            if let error = error {
                print("Hata oluştu: \(error.localizedDescription)")
                completion(50.0) // Varsayılan fiyatı geri döndürüyoruz
            } else {
                let price = product?.price ?? 50.0
                completion(price)
            }
        }
    }

}
