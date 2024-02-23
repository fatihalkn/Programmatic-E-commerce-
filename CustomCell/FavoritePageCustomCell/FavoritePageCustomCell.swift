//
//  FavoritePageCustomCell.swift
//  E-Commerce
//
//  Created by Fatih on 21.02.2024.
//

import UIKit
import SDWebImage
import SwipeCellKit

class FavoritePageCustomCell: SwipeCollectionViewCell {
    
    let productDetailService: ProductDetailServiceProtocol = ProductDetailService()

    var interface: SwipeCollectionViewCellDelegate?
    var products: Product?
    static let identifier = "FavoritePageCustomCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .a
        imageView.clipsToBounds = false
        imageView.image = UIImage()
        return imageView
    }()
    
    private let prodoctTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 4
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.text = "124124"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2        
        return label
    }()
    
    private let productCategory: UILabel = {
        let label = UILabel()
        label.text = "asfasfas"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .systemGray
        label.numberOfLines = 1
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        
        setupUI()
        imageViewConstrain()
        prodoctTitleConstrain()
        productCategoryConstrain()
        productPriceConstrain()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(product: Product) {
        
        self.products = product
        DispatchQueue.main.async {
            self.prodoctTitle.text = product.title
            self.productPrice.text = "\(product.price!)$"
            self.productCategory.text = "CATEGORY = \(product.category!)"
            self.imageView.sd_setImage(with: URL(string: product.image ?? "boş"))
        }
        
        
        
    }
}

//MARK: - Configure UI Constains
extension FavoritePageCustomCell {
    func setupUI() {
        self.backgroundColor = .bg
        self.layer.cornerRadius = 16
        self.addSubview(imageView)
        self.addSubview(prodoctTitle)
        self.addSubview(productPrice)
        self.addSubview(productCategory)
    }
    
    func imageViewConstrain() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor,multiplier: 0.5)
        ])
        
    }
    
    func prodoctTitleConstrain() {
        prodoctTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            prodoctTitle.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            prodoctTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 15),
            prodoctTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            prodoctTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])

    }
    
    func productPriceConstrain() {
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productPrice.centerXAnchor.constraint(equalTo: prodoctTitle.centerXAnchor),
            productPrice.topAnchor.constraint(equalTo: prodoctTitle.bottomAnchor,constant: 15),
            productPrice.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            productPrice.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
            
            
        ])

    }
    
    func productCategoryConstrain() {
        productCategory.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            productCategory.centerXAnchor.constraint(equalTo: prodoctTitle.centerXAnchor),
            productCategory.topAnchor.constraint(equalTo: prodoctTitle.bottomAnchor),
            productCategory.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            productCategory.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])

    }
    
}
