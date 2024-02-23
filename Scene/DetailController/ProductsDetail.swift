//
//  ProductsDetail.swift
//  E-Commerce
//
//  Created by Fatih on 16.02.2024.
//

import Foundation
import UIKit
import BLTNBoard

class ProductsDetail: UIViewController {
    
    var productID: Int?
    var productTitle: String?
    var prodcut: Product?
    
    private let detailService : ProductDetailServiceProtocol = ProductDetailService()
    
    private let productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .a
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let rateStarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .bg
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        return view
    }()
    
    private let productTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Box Bag Linar"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productRateLabel: UILabel = {
        let label = UILabel()
        label.text = "4.8"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDesriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "orem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productDesriptionTitle: UILabel = {
        let label = UILabel()
        label.text = "Desription"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$35.25"
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let addToCardButton: UIButton = {
        let button  = UIButton()
        button.setTitle("Add To Card", for: .normal)
        button.setImage(UIImage(named: "buttonBasket"), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .main
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var boardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "Sepet İşlemleri")
        item.image = .basket
        item.appearance.actionButtonBorderColor = .black
        item.appearance.actionButtonColor = .main
        item.actionButtonTitle = "sepete ekle"
        item.next = makeRootItem()
        item.actionHandler = {  _ in
            self.updateBasketArray()
            item.manager?.displayNextItem()
        }
        
        item.alternativeHandler = { _  in}
     
       return BLTNItemManager(rootItem: item)
    }()
    
    func makeRootItem() -> BLTNItem {
        let rootPage = BLTNPageItem(title: "Sepete başarıyla eklendi")
        rootPage.image = .okey
        rootPage.actionButtonTitle = "Sepete git"
        rootPage.appearance.actionButtonColor = .main
        rootPage.actionHandler = { _ in
           let vc = BasketController()
            self.navigationController?.pushViewController(vc, animated: true)
            
            
            
        }
        
        return rootPage
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchProductDetail()
        targetAddCardButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        radiusButtons()
    }
    
    
    func updateBasketArray() {
        guard let productID else { return }
        detailService.getProductsDetail(id: productID) { product, error in
            if let error = error {
                return
            }
            if let product {
                guard let userID = FirebaseManager.shared.userID else { return }
                 let product = product
                FirebaseManager.shared.updateBasketProduct(userID: userID, product: product, willAdd: true) { result in
                    switch result {
                    case .success(let success):
                        print("başarışı")
                    case .failure(let failure):
                        print("afsasfa")
                    }
                }

            }
           
        }
        
        
    }
    
   

    
    
    func targetAddCardButton() {
        addToCardButton.addTarget(self, action: #selector(clickedAddCardButton), for: .touchUpInside)
        
    }
    
    @objc func clickedAddCardButton() {
        boardManager.showBulletin(above: self)
        boardManager.backgroundViewStyle = .blurredLight
        
    
    }
   
    func configureUI(product: Product) {
        DispatchQueue.main.async {
            self.productImageView.sd_setImage(with: URL(string: product.image ?? ""))
            self.productTitleLabel.text = product.title
            self.productRateLabel.text = "\(product.rating?.rate ?? 5)"
            self.productDesriptionLabel.text = product.description
            self.productPriceLabel.text = "\(product.price ?? 0)$"
        }
    }
    
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(productImageView)
        view.addSubview(cardView)
        view.addSubview(productTitleLabel)
        view.addSubview(rateStarImageView)
        view.addSubview(productRateLabel)
        view.addSubview(productDesriptionTitle)
        view.addSubview(productDesriptionLabel)
        view.addSubview(productPriceLabel)
        view.addSubview(addToCardButton)
        productImageViewConstrains()
        productsCardViewConstrains()
        productsTitleLabel()
        productsRateStar()
        productsRateLabel()
        productsDesriptionTitle()
        productsDescriptionLabel()
        pruductsPrice()
        addCard()
        
    }
    
    func radiusButtons() {
        addToCardButton.layer.cornerRadius = addToCardButton.frame.height / 2
        addToCardButton.layer.masksToBounds = true
    }
    
    func fetchProductDetail() {
        guard let productID else { return }
        detailService.getProductsDetail(id: productID) { product, error in
            if let error = error {
                return
            }
            if let product {
                self.configureUI(product: product)
                

            }
           
        }
    }
    
    
}


//MARK: - Configure Constrains

extension ProductsDetail {
    
    func productImageViewConstrains() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //            productImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            productImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            productImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            productImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func productsCardViewConstrains() {
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: productImageView.bottomAnchor),
            cardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            cardView.heightAnchor.constraint(equalTo: productImageView.heightAnchor, multiplier: 1.2)
        ])
    }
    
    func productsTitleLabel() {
        NSLayoutConstraint.activate([
            productTitleLabel.topAnchor.constraint(equalTo: cardView.topAnchor,constant: 10),
            productTitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 30),
            productTitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor),
        ])
    }
    
    func productsRateStar() {
        NSLayoutConstraint.activate([
            rateStarImageView.topAnchor.constraint(equalTo: productTitleLabel.bottomAnchor),
            rateStarImageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 30),
            rateStarImageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.1),
            rateStarImageView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.1)
        ])
    }
    
    func productsRateLabel() {
        NSLayoutConstraint.activate([
            productRateLabel.centerYAnchor.constraint(equalTo: rateStarImageView.centerYAnchor),
            productRateLabel.leadingAnchor.constraint(equalTo: rateStarImageView.trailingAnchor, constant: 30),
            productRateLabel.heightAnchor.constraint(equalTo: rateStarImageView.heightAnchor)
        ])
    }
    
    func productsDesriptionTitle() {
        NSLayoutConstraint.activate([
            productDesriptionTitle.topAnchor.constraint(equalTo: productRateLabel.bottomAnchor, constant: 30),
            productDesriptionTitle.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 30),
            productDesriptionTitle.trailingAnchor.constraint(lessThanOrEqualTo: cardView.trailingAnchor)
        ])
    }
    
    func productsDescriptionLabel() {
        
        NSLayoutConstraint.activate([
            productDesriptionLabel.topAnchor.constraint(equalTo: productDesriptionTitle.bottomAnchor,constant: 10),
            productDesriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -30),
            productDesriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 30),
            productDesriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: addToCardButton.topAnchor)
        ])
    }
    
    func pruductsPrice() {
        NSLayoutConstraint.activate([
            productPriceLabel.heightAnchor.constraint(equalToConstant: 30),
            productPriceLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,constant: -8),
            productPriceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor,constant: 30),
            productPriceLabel.trailingAnchor.constraint(lessThanOrEqualTo: addToCardButton.leadingAnchor)
        ])
    }
    
    func addCard() {
        NSLayoutConstraint.activate([
            addToCardButton.heightAnchor.constraint(equalToConstant: 40),
            addToCardButton.bottomAnchor.constraint(equalTo: cardView.bottomAnchor,constant: -8),
            addToCardButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor,constant: -30),
            addToCardButton.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.5)
            
        ])
        
    }
}
