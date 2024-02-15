//
//  HomePageCustomCell.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit
import SDWebImage

class HomePageCustomCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage()
        imageView.image = .a
        imageView.clipsToBounds = true
        return imageView
        
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(.favorite, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .gray.withAlphaComponent(0.5)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var productTitle: UILabel = {
        let label = UILabel()
        label.text = "aaa"
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productCategory: UILabel = {
        let label = UILabel()
        label.text = "bbb"
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .systemGray4
        label.textAlignment = .center
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.text = "12412$"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    
    static let identifier = "HomePageCustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radiusUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension HomePageCustomCell {
    
    func radiusUI() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        favoriteButton.layer.masksToBounds = true
    }
    
    func configure(data: Product) {
        productTitle.text = data.title
        productCategory.text = "\(data.category!)"
        productPrice.text = "\(data.price!)$"
        imageView.sd_setImage(with: URL(string: data.image ?? "boş"))
        
    }
    
    
    private func setupUI() {
        self.backgroundColor = .bg
        self.layer.cornerRadius = 16
        
        addSubview(imageView)
        addSubview(favoriteButton)
        addSubview(productTitle)
        addSubview(productCategory)
        addSubview(productPrice)
     
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: imageView.topAnchor,constant: 10),
            favoriteButton.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            favoriteButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            favoriteButton.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.2),
            favoriteButton.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            productTitle.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            productTitle.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            productTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            productTitle.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            productCategory.centerXAnchor.constraint(equalTo: productTitle.centerXAnchor),
            productCategory.topAnchor.constraint(equalTo: productTitle.bottomAnchor, constant: 5),
            productCategory.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            productCategory.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            productPrice.centerXAnchor.constraint(equalTo: productCategory.centerXAnchor),
            productPrice.topAnchor.constraint(equalTo: productCategory.bottomAnchor, constant: 5),
            productPrice.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            productPrice.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ])
        
        
    }
}
