//
//  CustomButtons.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class CustomButtons: UIButton {
    
    override init(frame: CGRect) {
        super .init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backroundColor: UIColor? = nil, image: UIImage? = nil, borderWidth: CGFloat? = nil) {
        self.init(frame: .zero)
        set(title: title, titleColor: titleColor, font: font, backroundColor: backroundColor, image: image, borderWidth: borderWidth)
    }
    
    
    func configure() {
        //////////////////////
        
    }
    
    private func set(title: String? = nil, titleColor: UIColor? = nil, font: UIFont? = nil, backroundColor: UIColor? = nil, image: UIImage? = nil, borderWidth: CGFloat? = nil) {
        
        if let title = title {
            setTitle(title, for: .normal)
        }
        
        if let titleColor = titleColor {
            setTitleColor(titleColor, for: .normal)
        }
        
        if let font = font {
            titleLabel?.font = font
        }
        
        if let backroundColor = backroundColor {
            self.backgroundColor = backroundColor
        }
        
        if let image = image {
            setImage(image, for: .normal)
        }
        
        if let borderWidth = borderWidth {
            self.layer.borderWidth = borderWidth
        }
        
    }
    
    
}
