//
//  RegisterController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class RegisterController: UIViewController {
    
    let userNameTextField = CustomTextFields(isSecureText: false, 
                                             placeHolder: "Enter username",
                                             leftImage: UIImage(named: "person")!)
    let emailTextField = CustomTextFields(isSecureText: false, 
                                          placeHolder: "Enter your email",
                                          leftImage: UIImage(named: "mail")!)
    let passwordTextField = CustomTextFields(isSecureText: true, 
                                             placeHolder: "Enter your password",
                                             leftImage: UIImage(named: "password")!)
    let registerButton = CustomButtons(title: "Create Account", 
                                       titleColor: .white,
                                       font: .systemFont(ofSize: 17),
                                       backroundColor: .main)
    let loginButton = CustomButtons(title: "Login", titleColor: .main, 
                                    font: .systemFont(ofSize: 17),
                                    backroundColor: .clear)
    
    let label = CustomLabel()
    
    let signInGoogleButton = CustomButtons(title: "Sign In with Google",
                                           titleColor: .black,
                                           font: .systemFont(ofSize: 18, weight: .semibold),
                                           image: UIImage(named: "google"),
                                           borderWidth: 1)
    let signInFacebookButton = CustomButtons(title: "Sign In with Google", 
                                             titleColor: .black,
                                             font: .systemFont(ofSize: 18, weight: .semibold), 
                                             image: UIImage(named: "facebook"),
                                             borderWidth: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        radiusUI()
    }
    
    func radiusUI() {
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        registerButton.layer.masksToBounds = true
        
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height / 2
        userNameTextField.layer.masksToBounds = true
        
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.layer.masksToBounds = true
        
        signInGoogleButton.layer.cornerRadius = signInGoogleButton.frame.height / 2
        signInGoogleButton.layer.masksToBounds = true
        
        signInFacebookButton.layer.cornerRadius = signInFacebookButton.frame.height / 2
        signInFacebookButton.layer.masksToBounds = true
        
    }
 
    func configureWithExtantion() {
        view.customAddSubViews(userNameTextField,
                         emailTextField,
                         passwordTextField,
                         registerButton,
                         loginButton,
                         label,
                         signInGoogleButton,
                         signInFacebookButton)
   
        userNameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 50,
                                 paddingLeft: 30,
                                 paddingRight: 30,
                                 height: 50)
        
        emailTextField.anchor(top: userNameTextField.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 30,
                              paddingLeft: 30,
                              paddingRight: 30,
                              height: 50)
        
        passwordTextField.anchor(top: emailTextField.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 30,
                                 paddingLeft: 30,
                                 paddingRight: 30,
                                 height: 50)
        
        registerButton.anchor(top: passwordTextField.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 50,
                              paddingLeft: 30,
                              paddingRight: 30,
                              height: 50)
        
        loginButton.anchor(top: registerButton.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: 15,
                           paddingLeft: 100,
                           paddingRight: 100,
                           height: 50)
        
        label.anchor(top: loginButton.bottomAnchor,
                     left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingTop: 15,
                     paddingLeft: 100,
                     paddingRight: 100,
                     height: 50)
        
        signInGoogleButton.anchor(top: label.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 15,
                                  paddingLeft: 30,
                                  paddingRight: 30,
                                  height: 50)
        
        signInFacebookButton.anchor(top: signInGoogleButton.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    paddingTop: 15,
                                    paddingLeft: 30,
                                    paddingRight: 30,
                                    height: 50)
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        configureWithExtantion()
    }
}
   
