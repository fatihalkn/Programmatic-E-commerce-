//
//  HomeMainCollectionHeader.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit

class HomeMainCollectionHeader: UICollectionReusableView {
    static let identifier = "HomeMainCollectionHeader"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .brown
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
