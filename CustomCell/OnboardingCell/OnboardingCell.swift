//
//  OnboardingCell.swift
//  E-Commerce
//
//  Created by Fatih on 24.02.2024.
//

import UIKit

protocol OnboardingCellDelegate {
    
}

class OnboardingCell: UICollectionViewCell {
    
    var delegate: OnboardingCellDelegate?
    static let identifier = "OnboardingCell"
    
     let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.image = .o1
        imageView.layer.cornerRadius = 16
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
     let label: UILabel = {
        let label = UILabel()
        label.text = "afafafaf124124cqascdacdadc12e1e"
        label.textAlignment = .center
        label.numberOfLines = 3
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descLabel: UILabel = {
       let label = UILabel()
       label.text = "afafafaf124124cqascdacdadc12e1e"
       label.textAlignment = .center
       label.numberOfLines = 3
       label.textColor = .darkGray
       label.font = .systemFont(ofSize: 13, weight: .medium)
       label.translatesAutoresizingMaskIntoConstraints = false
       return label
   }()
    
  
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

}

//MARK: - Configure UIConstrain
extension OnboardingCell {

    func setupUI() {
        
       
        
        self.addSubview(imageView)
        self.addSubview(label)
        self.addSubview(descLabel)
        imageViewConstrain()
        labelConstrain()
        descLabelConfigure()
        
    }
    
    
    
    
    func imageViewConstrain() {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor,constant: 100),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 50),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -50),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5),
            
        ])
        
    }
    
    func labelConstrain() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 10),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
            
        ])
    }
    
    func descLabelConfigure() {
        NSLayoutConstraint.activate([
            descLabel.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 15),
            descLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            descLabel.trailingAnchor.constraint(equalTo: label.trailingAnchor),
            descLabel.bottomAnchor.constraint(lessThanOrEqualTo: safeAreaLayoutGuide.bottomAnchor)
           
        ])
    }

    
}
