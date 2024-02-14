//
//  HomePageCustomCell.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit

class HomePageCustomCell: UICollectionViewCell {
    
    static let identifier = "HomePageCustomCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .red
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
