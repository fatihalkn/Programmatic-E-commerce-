//
//  CustomTextFields.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class CustomTextFields: UITextField {
    
    //MARK: - Properties
    private var placeholderInsets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(isSecureText: Bool, placeHolder: String, leftImage: UIImage) {
        self.init(frame: .zero)
        set(isSecureText: isSecureText, placeHolder: placeHolder, leftImage: leftImage)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let leftView else { return }
        leftView.frame.origin.x = 10
        let leftPlaceholderInset = leftView.frame.origin.x + leftView.frame.width + 10
        let rightPlaceholderInset: CGFloat = 20
        placeholderInsets = UIEdgeInsets(top: 0, left: leftPlaceholderInset, bottom: 0, right: rightPlaceholderInset)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: placeholderInsets)
    }
    
    func configure() {
        borderStyle = .none
        textColor = .black
        backgroundColor = .secondarySystemBackground
        leftViewMode = .always
    }
    
    private func set(isSecureText: Bool, placeHolder: String, leftImage: UIImage) {
        isSecureTextEntry = isSecureText
        placeholder = placeHolder
        let leftImageView = UIImageView()
        leftImageView.contentMode = .scaleAspectFit
        leftImageView.image = leftImage
        leftView = leftImageView
    }
}
