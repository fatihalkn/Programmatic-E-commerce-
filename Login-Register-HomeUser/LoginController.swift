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
    
    
    let registerButton = CustomButtons(title: "Register",
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
    
    
    let otherLoginLabel : UILabel = {
        let label = UILabel()
        label.text = "Or using other method"
        label.textColor = .systemGray
        label.backgroundColor = .clear
        return label
    }()
    
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        radiusUI()
        
    }
    
    
    
    //MARK: - Helpers
    
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
        configureUserNameTextField()
        configurePasswordTextField()
        configureLoginButton()
        configureRegisterButton()
        configureOtherLogin()
        configureSingInGoogleButton()
        configureSingInFaceBookButton()
        
    }
    
    
    func configureUserNameTextField() {
        view.addSubview(userNameTextField)
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func configurePasswordTextField() {
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 30),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureLoginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            
        ])
        
        
    }
    
    func configureRegisterButton() {
        view.addSubview(registerButton)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15),
            registerButton.centerXAnchor.constraint(equalTo: loginButton.centerXAnchor),
            registerButton.widthAnchor.constraint(lessThanOrEqualTo: loginButton.widthAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureOtherLogin() {
        view.addSubview(otherLoginLabel)
        otherLoginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            otherLoginLabel.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 30),
            otherLoginLabel.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor),
            otherLoginLabel.widthAnchor.constraint(lessThanOrEqualTo: registerButton.widthAnchor),
            otherLoginLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func configureSingInGoogleButton() {
        view.addSubview(singInGoogleButton)
        singInGoogleButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            singInGoogleButton.topAnchor.constraint(equalTo: otherLoginLabel.bottomAnchor, constant: 15),
            singInGoogleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            singInGoogleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            singInGoogleButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func configureSingInFaceBookButton() {
        view.addSubview(singInFaceBookButton)
        singInFaceBookButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            singInFaceBookButton.topAnchor.constraint(equalTo: singInGoogleButton.bottomAnchor, constant: 10),
            singInFaceBookButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            singInFaceBookButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            singInFaceBookButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
    }
}
