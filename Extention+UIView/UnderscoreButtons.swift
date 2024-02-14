//
//  UnderscoreButtons.swift
//  E-Commerce
//
//  Created by Fatih on 14.02.2024.
//

import UIKit


extension UIView {
    
    func addButtonBorderWithColor(color: UIColor, witdh: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - witdh, width: self.frame.size.width, height: witdh)
        self.layer.addSublayer(border)
    }
    
    
    func removeBorder(edge: UIRectEdge) {
        let borderTag = 999
        self.layer.sublayers?.removeAll(where: {$0.name == "border\(edge.rawValue)"})
    }
}
