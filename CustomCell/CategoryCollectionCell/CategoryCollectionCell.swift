//
//  CategoryCollectionCell.swift
//  E-Commerce
//
//  Created by Fatih on 22.02.2024.
//

import UIKit

class CategoryCollectionCell: UICollectionViewCell {
    var isSelectedCategory: Bool = false {
        didSet {
            categoryLabel.backgroundColor = isSelectedCategory ? .bc : .bg
        }
    }
    private let service = CategoryItemsService()
    static let identifier = "CategoryCollectionCell"
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.borderWidth = 1
        label.backgroundColor = .bg
        return label
    }()
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
       
        setupUI()
        categoryLabelConstarin()

    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRadius()
    }
    
    
    func setupUI() {
        self.addSubview(categoryLabel)
        self.backgroundColor = .white
        
    }
    
    func setupRadius() {
        self.layer.cornerRadius = 16
        categoryLabel.layer.cornerRadius = categoryLabel.frame.size.height / 2
        categoryLabel.layer.masksToBounds = true
        
    }
    
    
    func configure(data: Category) {
        switch data {
        case .electronics:
            service.getElectronicsProducts { prodcut , error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.categoryLabel.text = "Electronics"
                    }
                }
            }
        case .jewelery:
            service.getJeweleryProducts { product, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.categoryLabel.text = "Jewelery"
                    }
                }
            }
        case .menSClothing:
            service.getMensclothingProducts { product, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.categoryLabel.text = "Men's Clothing"
                    }
                }
            }
        case .womenSClothing:
            service.getWomensclothingProducts { product, error  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    DispatchQueue.main.async {
                        self.categoryLabel.text = "Women's Clothing"
                    }
                }
            }
            
        }
    }
    
    
}

extension CategoryCollectionCell {
    
    func categoryLabelConstarin() {
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            categoryLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            categoryLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
