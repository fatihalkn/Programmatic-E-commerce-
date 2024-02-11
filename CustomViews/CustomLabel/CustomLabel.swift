//
//  CustomLabel.swift
//  E-Commerce
//
//  Created by Fatih on 11.02.2024.
//

import UIKit

class CustomLabel: UILabel {

    override init(frame: CGRect) {
        super .init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
       text = "Or using other method"
       textColor = .systemGray
       backgroundColor = .clear
    }
    
    
}


