//
//  SearchPageCustomCell.swift
//  E-Commerce
//
//  Created by Fatih on 17.02.2024.
//

import UIKit

class SearchPageCustomCell: UICollectionViewCell {
    
    static let identifier = "SearchPageCustomCell"
    
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
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productPrice: UILabel = {
        let label = UILabel()
        label.text = "12412$"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radiusUI()
    }
    
    
}

extension SearchPageCustomCell {
    
    func radiusUI() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        favoriteButton.layer.masksToBounds = true
    }
    
    func configure(data: Product) {
        productTitle.text = data.title
        productCategory.text = "CATEGORY = \(data.category!)"
        productPrice.text = "\(data.price!)$"
        imageView.sd_setImage(with: URL(string: data.image ?? "boş"))
        
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        
        addSubview(imageView)
//        addSubview(favoriteButton)
        addSubview(productTitle)
       addSubview(productCategory)
      addSubview(productPrice)
        
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3)
        ])
        
        
        NSLayoutConstraint.activate([
            productTitle.centerYAnchor.constraint(equalTo: imageView.centerYAnchor,constant: -40),
            productTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            productTitle.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor),
            productTitle.heightAnchor.constraint(equalToConstant: 50)
           
            
        ])
        
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: productTitle.bottomAnchor,constant: 50),
            productPrice.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            productPrice.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        
        NSLayoutConstraint.activate([
            productCategory.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            productCategory.leadingAnchor.constraint(equalTo: imageView.trailingAnchor,constant: 5),
            productCategory.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    
    
    
    
    
    
}
