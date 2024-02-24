//
//  HeaderCollectionViewCell.swift
//  E-Commerce
//
//  Created by Fatih on 14.02.2024.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    var product: Product?
    
    private lazy var mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .b
        return imageView
    }()
    
    private lazy var productsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = .a
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
        
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.numberOfLines = 4
        label.text = "%24 of Shopping Today on bag pruchases"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    static let identifier = "HeaderCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()

        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        radiusUI()
        self.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func radiusUI() {
        
        mainImageView.layer.cornerRadius = mainImageView.frame.height / 2
        mainImageView.layer.masksToBounds = true
    }
    
    
    func configure(data: Product) {
        self.product = data
        DispatchQueue.main.async {
            self.titleLabel.text = "\(data.price!) $ !!!"
            self.productsImageView.sd_setImage(with: URL(string: "\(data.image!)"))
        }
    }
   
}




extension HeaderCollectionViewCell {
    
    private func setupUI() {
        self.layer.cornerRadius = 16
        backgroundColor = .white
        addSubview(mainImageView)
        addSubview(productsImageView)
        addSubview(titleLabel)
        
        
        
        NSLayoutConstraint.activate([
            mainImageView.centerXAnchor.constraint(equalTo: self.leadingAnchor,constant: -50),
            mainImageView.centerYAnchor.constraint(equalTo: self.bottomAnchor),
            mainImageView.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3),
            mainImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3)
        ])
        
        NSLayoutConstraint.activate([
            productsImageView.topAnchor.constraint(equalTo: self.topAnchor),
            productsImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            productsImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            productsImageView.widthAnchor.constraint(equalTo: self.widthAnchor,multiplier: 0.1)
        ])

        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: productsImageView.leadingAnchor,constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            
        ])
        
        
        
      
                              
       
        
        
    }
    
}
