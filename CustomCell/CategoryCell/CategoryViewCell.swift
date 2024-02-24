//
//  CategoryViewCell.swift
//  E-Commerce
//
//  Created by Fatih on 16.02.2024.
//

import UIKit
import SDWebImage

class CategoryViewCell: UICollectionViewCell {
    
    static let identifier = "CategoryViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage()
        imageView.clipsToBounds = true
        imageView.image = .a
        return imageView
    }()
    
    private lazy var categoryTitle: UILabel = {
        let label = UILabel()
        label.text = "New Arrivals"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let service = CategoryItemsService()
    
    //MARK: - Life-Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupUI()
        configureCategoryTitler()
        configureİmageView()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        self.addSubview(categoryTitle)
        self.addSubview(imageView)
        
    }
    
    func setupRadius() {
        self.layer.cornerRadius = 16
        
    }
    
    func configure(data: Category) {
        switch data {
        case .electronics:
            service.getElectronicsProducts { products, error in
                if let error = error {
                    print(error.localizedDescription)
                    
                } else {
                    DispatchQueue.main.async {
                        self.categoryTitle.text = "Electronics"
                    }
                    self.imageView.sd_setImage(with: URL(string: products.randomElement()?.image ?? "boş"))
                    
                    
                }
            }
        case .jewelery:
            service.getJeweleryProducts { products, error in
                if let error = error {
                    print(error.localizedDescription)

                } else {
                    DispatchQueue.main.async {
                        self.categoryTitle.text = "Jewelery"

                    }
                    self.imageView.sd_setImage(with: URL(string: products.randomElement()?.image ?? "boş"))
                }
            }
        case .menSClothing:
            service.getMensclothingProducts { products, error in
                if let error = error {
                    print(error.localizedDescription)

                } else {
                    DispatchQueue.main.async {
                        self.categoryTitle.text = "Men's Clothing"

                    }
                    self.imageView.sd_setImage(with: URL(string: products.randomElement()?.image ?? "boş"))
                }
            }
        case .womenSClothing:
            service.getWomensclothingProducts { products, error in
                if let error = error {
                    print(error.localizedDescription)

                } else {
                    DispatchQueue.main.async {
                        self.categoryTitle.text = "Women's Clothing"

                    }
                    self.imageView.sd_setImage(with: URL(string: products.randomElement()?.image ?? "boş"))
                    
                }
            }
        }
        
    }
}

//MARK: - Configure Constraints

extension CategoryViewCell {
    
   
    
    func configureCategoryTitler() {
        NSLayoutConstraint.activate([
            categoryTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            categoryTitle.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            categoryTitle.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor, multiplier: 0.3),
            categoryTitle.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func configureİmageView() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 200),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        
        ])
    }
    

}
