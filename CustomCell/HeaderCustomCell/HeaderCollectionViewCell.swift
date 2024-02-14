//
//  HeaderCollectionViewCell.swift
//  E-Commerce
//
//  Created by Fatih on 14.02.2024.
//

import UIKit

class HeaderCollectionViewCell: UICollectionViewCell {
    
    private lazy var mainImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HeaderCollectionViewCell {
    
    private func setupUI() {
        backgroundColor = .green
        addSubview(mainImageView)
        addSubview(titleLabel)
        
        
        mainImageView.anchor(top: safeAreaLayoutGuide.topAnchor,left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor,
            right: safeAreaLayoutGuide.rightAnchor)
        
        
        titleLabel.anchor(top: mainImageView.topAnchor,left: mainImageView.leftAnchor,bottom: mainImageView.bottomAnchor,right: mainImageView.rightAnchor,paddingTop: 20,
        paddingLeft: 20,  paddingBottom: 20, paddingRight: 20)
    }
    
}
