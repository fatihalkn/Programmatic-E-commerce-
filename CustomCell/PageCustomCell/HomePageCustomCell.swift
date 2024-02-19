//
//  HomePageCustomCell.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit
import SDWebImage
protocol FavoriteButtonDelegate {
    func clickedFavoriteButton(id:Int)
}


class HomePageCustomCell: UICollectionViewCell {
    var delegate: FavoriteButtonDelegate?
    
    var product: Product?
    private var isFavorite: Bool = false
    
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
        addTargetFavoriteButton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        checkIsProductsFavorite()
        radiusUI()

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func addTargetFavoriteButton() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonClick), for: .touchUpInside)
    }
    
    @objc func favoriteButtonClick() {

        setButtonColor(isFavorite: !isFavorite)
        handleFavoriteButton()
        delegate?.clickedFavoriteButton(id: product?.id ?? 0)
    }
    
    func handleFavoriteButton() {
        guard let userID = FirebaseManager.shared.userID, let product  else {
            setButtonColor(isFavorite: isFavorite)
            return
        }
        
        FirebaseManager.shared.updateFavoriteProduct(userID: userID, product: product, willAdd: !isFavorite) { result in
            switch result {
            case .success(_):
                break
            case .failure(let failure):
                self.setButtonColor(isFavorite: false)
                if self.isFavorite {
                    print(failure.localizedDescription)
                    
                } else {
                    print(failure.localizedDescription)
                }
            }
        }
    }
    
    func updateTappedNews() {
        guard let userID = FirebaseManager.shared.userID, let productTitle = product?.title else { return }
        FirebaseManager.shared.updateUserTapperdProduts(userID: userID, productTitle: productTitle)
    }
    
    func checkIsProductsFavorite() {
        FirebaseManager.shared.checkIsProductsFavorite(produtcs: product) { isFavorite in
            self.isFavorite = isFavorite
            self.setButtonColor(isFavorite: isFavorite)
        }
    }
    
    func setButtonColor(isFavorite: Bool) {
        DispatchQueue.main.async {
            if isFavorite {
                self.favoriteButton.setImage(.hearthFill, for: .normal)
                self.favoriteButton.tintColor = .red
            } else {
                self.favoriteButton.setImage(.favorite, for: .normal)
                self.favoriteButton.tintColor = .white
            }

        }
    }
    
    
}


extension HomePageCustomCell {
    
    func radiusUI() {
        favoriteButton.layer.cornerRadius = favoriteButton.frame.width / 2
        favoriteButton.layer.masksToBounds = true
    }
    
   
    

    
    func configure(data: Product) {
        self.product = data
        productTitle.text = data.title
        productCategory.text = "CATEGORY =\(data.category!)"
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
