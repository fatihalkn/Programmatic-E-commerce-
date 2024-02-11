//
//  LoginController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit

class LoginController: UIViewController {
    
    //MARK: - Varibles
    let userNameTextField = CustomTextFields(isSecureText: false,
                                             placeHolder: "Enter your mail",
                                             leftImage: UIImage(named: "mail")!)
    
    let passwordTextField = CustomTextFields(isSecureText: true,
                                             placeHolder: "Enter your password",
                                             leftImage: UIImage(named: "password")!)
    
    let loginButton = CustomButtons(title: "Login",
                                    titleColor: .white,
                                    font: .systemFont(ofSize: 17),
                                    backroundColor: .main)
    
    
    @objc let registerButton = CustomButtons(title: "Register",
                                       titleColor: .main,
                                       font: .systemFont(ofSize: 17),
                                       backroundColor: .clear)
    
    let singInGoogleButton = CustomButtons(title: "Sign In with Google",
                                           titleColor: .black, font: .systemFont(ofSize: 18, weight: .semibold),
                                           backroundColor: .clear,
                                           image: UIImage(named: "google"),
                                           borderWidth: 1)
    
    let singInFaceBookButton = CustomButtons(title: "Sign In with Facebook",
                                             titleColor: .black,
                                             font: .systemFont(ofSize: 18, weight: .semibold),
                                             backroundColor: .clear, image: UIImage(named: "facebook"),
                                             borderWidth: 1)
    let otherLoginLabel = CustomLabel()
  
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargetRegisterButton()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        radiusUI()
        
    }
  
    //MARK: - Helpers
    
    
    func addTargetRegisterButton() {
        registerButton.addTarget(self, action: #selector(registerButtonCliced), for: .touchUpInside)
        
    }
    
    @objc func registerButtonCliced() {
        let vc = RegisterController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func radiusUI() {
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.layer.masksToBounds = true
        
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height / 2
        userNameTextField.layer.masksToBounds = true
        
        passwordTextField.layer.cornerRadius = passwordTextField.frame.height / 2
        passwordTextField.layer.masksToBounds = true
        
        singInGoogleButton.layer.cornerRadius = singInGoogleButton.frame.height / 2
        singInGoogleButton.layer.masksToBounds = true
        
        singInFaceBookButton.layer.cornerRadius = singInFaceBookButton.frame.height / 2
        singInFaceBookButton.layer.masksToBounds = true
        
    }
    
    func setupUI() {
        view.backgroundColor = .systemBackground
        configureWithExtention()
 
    }
    
    func configureWithExtention() {
        view.customAddSubViews(userNameTextField, 
                         passwordTextField,
                         passwordTextField,
                         loginButton,
                         registerButton,
                         otherLoginLabel,
                         singInGoogleButton,
                         singInFaceBookButton)

        userNameTextField.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 100,
                                 paddingLeft: 30,
                                 paddingRight: 30,
                                 height: 50)
        
        passwordTextField.anchor(top: userNameTextField.bottomAnchor,
                                 left: view.leftAnchor,
                                 right: view.rightAnchor,
                                 paddingTop: 30,
                                 paddingLeft: 30,
                                 paddingRight: 30,
                                 height: 50)
        loginButton.anchor(top: passwordTextField.bottomAnchor,
                           left: view.leftAnchor,
                           right: view.rightAnchor,
                           paddingTop: 30,
                           paddingLeft: 30,
                           paddingRight: 30,
                           height: 50)
        
        registerButton.anchor(top: loginButton.bottomAnchor,
                              left: view.leftAnchor,
                              right: view.rightAnchor,
                              paddingTop: 50,
                              paddingLeft: 30,
                              paddingRight: 30,
                              height: 50)
        otherLoginLabel.anchor(top: registerButton.bottomAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               paddingTop: 30,
                               paddingLeft: 110,
                               paddingRight: 110,
                               height: 30)
        
        singInGoogleButton.anchor(top: otherLoginLabel.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  paddingTop: 15,
                                  paddingLeft: 30,
                                  paddingRight: 30,
                                  height: 50)
        singInFaceBookButton.anchor(top: singInGoogleButton.bottomAnchor,
                                    left: view.leftAnchor,
                                    right: view.rightAnchor,
                                    paddingTop: 10,
                                    paddingLeft: 30,
                                    paddingRight: 30,
                                    height: 50)
    }
}
