//
//  BasketPageCell.swift
//  E-Commerce
//
//  Created by Fatih on 23.02.2024.
//

import UIKit
import SwipeCellKit

class BasketPageCell: SwipeCollectionViewCell {
    
    static let identifier = "BasketPageCell"
    let productDetailService: ProductDetailServiceProtocol = ProductDetailService()
    
    var product: Product?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .a
        imageView.clipsToBounds = false
        imageView.image = UIImage()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let prodoctTitle: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 4
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let productPrice: UILabel = {
        let label = UILabel()
        label.text = "124124"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stepperLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.maximumValue = 9
        stepper.maximumValue = 0
        stepper.translatesAutoresizingMaskIntoConstraints = false
        return stepper
    }()
    
    
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
        stepperTarget()
        imageViewConstrain()
        productTitleConstrain()
        stepperConstrain()
        stepperLabelConstrain()
        productPriceConstrain()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stepper.minimumValue = 1
        stepper.maximumValue = 9
        stepper.stepValue = 1
    }
    
    
    
    func stepperTarget() {
        stepper.addTarget(self, action: #selector(clickedStepper), for: .valueChanged)
    }
    
    @objc func clickedStepper() {
        let newValue = Int(stepper.value)
        stepperLabel.text = String(newValue)
    }
    
    
    
    func configure(id: Int?) {
        if let prodcutID = id {
            productDetailService.getProductsDetail(id: prodcutID) { product, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.updateUI(with: product!)
                }
            }
        }
        
    }
    
    
    
    func updateUI(with product: Product) {
        self.product = product
        DispatchQueue.main.async {
            self.prodoctTitle.text = product.title
            self.productPrice.text = "\(product.price!)$"
            self.imageView.sd_setImage(with: URL(string: product.image ?? "boş"))
        }
    }
    
    
}


extension BasketPageCell {
    func setupUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 16
        self.addSubview(imageView)
        self.addSubview(prodoctTitle)
        self.addSubview(productPrice)
        self.addSubview(stepper)
        self.addSubview(stepperLabel)
//
    }
    
    func imageViewConstrain() {
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1.2)
            
        ])
    }
    
    func productTitleConstrain() {
        NSLayoutConstraint.activate([
            prodoctTitle.topAnchor.constraint(equalTo: imageView.topAnchor),
            prodoctTitle.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            prodoctTitle.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor,constant: 20)
            
            
            
            
        ])
    }
    
    func stepperConstrain() {
        NSLayoutConstraint.activate([
            stepper.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: 20),
            stepper.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            
           
        ])
    }
    
   
    
    func stepperLabelConstrain() {
        NSLayoutConstraint.activate([
            stepperLabel.centerYAnchor.constraint(equalTo: stepper.centerYAnchor),
            stepperLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor,constant: 10)
            
        ])
        
    }
    
    func productPriceConstrain() {
        NSLayoutConstraint.activate([
            productPrice.centerYAnchor.constraint(equalTo: stepperLabel.centerYAnchor,constant: 40),
            productPrice.leadingAnchor.constraint(equalTo: stepper.trailingAnchor,constant: 40),
            productPrice.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
            
        ])
    }
}
