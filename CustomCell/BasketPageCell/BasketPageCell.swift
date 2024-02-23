//
//  BasketPageCell.swift
//  E-Commerce
//
//  Created by Fatih on 23.02.2024.
//

import UIKit

class BasketPageCell: UICollectionViewCell {
    
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
        label.font = .systemFont(ofSize: 12, weight: .semibold)
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
    }
    
    
    
    func stepperTarget() {
        stepper.addTarget(self, action: #selector(clickedStepper), for: .valueChanged)
    }
    
    @objc func clickedStepper() {
        stepperLabel.text = String(stepper.value)
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
        self.backgroundColor = .bg
        self.layer.cornerRadius = 16
        self.addSubview(imageView)
        self.addSubview(prodoctTitle)
        self.addSubview(productPrice)
        self.addSubview(stepper)
        self.addSubview(stepperLabel) 

    }
    
    func imageViewConstrain() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor)
        ])
    }
    
    func productTitleConstrain() {
        NSLayoutConstraint.activate([
            prodoctTitle.topAnchor.constraint(equalTo: imageView.topAnchor),
            prodoctTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            prodoctTitle.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        ])
    }
    
    func productPriceConstrain() {
        NSLayoutConstraint.activate([
            productPrice.topAnchor.constraint(equalTo: stepperLabel.topAnchor),
            productPrice.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            productPrice.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            
        ])
    }
    
    func stepperConstrain() {
        NSLayoutConstraint.activate([
            stepper.topAnchor.constraint(equalTo: prodoctTitle.bottomAnchor),
            stepper.leadingAnchor.constraint(equalTo: imageView.trailingAnchor),
            stepper.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            
        ])
    }
    
    func stepperLabelConstrain() {
        NSLayoutConstraint.activate([
            stepperLabel.topAnchor.constraint(equalTo: stepper.topAnchor),
            stepperLabel.leadingAnchor.constraint(equalTo: stepper.trailingAnchor),
            stepperLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
