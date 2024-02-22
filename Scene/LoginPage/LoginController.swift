//
//  LoginController.swift
//  E-Commerce
//
//  Created by Fatih on 10.02.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn
import ProgressHUD

class LoginController: UIViewController {
    
    //MARK: - Varibles
    let userNameTextField = CustomTextFields(isSecureText: false,
                                             placeHolder: "Enter your mail",
                                             leftImage: UIImage(named: "mail")!,userName: "fatihalkan@gmail.com", password: nil)
    
    let passwordTextField = CustomTextFields(isSecureText: true,
                                             placeHolder: "Enter your password",
                                             leftImage: UIImage(named: "password")!,userName: nil,password: "123123")
    
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
    let otherLoginLabel = CustomLabel()
  
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addTargetRegisterButton()
        addTargetGoogleButton()
        loginButtonTap()
        
        CategoryItemsService.shared.getElectronicsProducts { _, _ in
            
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        radiusUI()
        
    }
    
    //MARK: - LOGİN BUTTON
    
    func loginButtonTap() {
        loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
    }
    
    @objc func loginButtonClicked() {
        guard let userName = userNameTextField.text, !userName.isEmpty else {
            showError(text: "Kullanıcı adı Boş Bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        
        guard let password = passwordTextField.text, !password.isEmpty else {
            showError(text: "Şifre Boş Bırakılamaz", image: nil, interaction: false, delay: nil)
            return
        }
        showLoading(text: "Giriş Yaplıyor...", interaction: false)
        FirebaseManager.shared.signInUser(with: userName, password: password) { result in
            switch result {
            case .success(_):
                self.showSucceed(text: "Giriş işlemi Başarılı", interaction: false, delay: nil)
                let vc = HomeController()
                self.navigationController?.pushViewController(vc, animated: true)
            case .failure(let failure):
                self.showError(text: "Giriş işlemi başarısız\(failure.localizedDescription)", image: nil, interaction: false, delay: 2)
            }
        }
        
    }
  
    func addTargetRegisterButton() {
        registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
        
    }
    
    @objc func registerButtonClicked() {
        let vc = RegisterController()
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    //MARK: - GOOGLE SIGN-IN
    func addTargetGoogleButton() {
        singInGoogleButton.addTarget(self, action: #selector(googleButtonClicked), for: .touchUpInside)
    }
    
    @objc func googleButtonClicked() {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let confing = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = confing
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) {  result, error in
            if let  error = error {
                print(error.localizedDescription)
            }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            Auth.auth().signIn(with: credential) { result , error  in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.showSucceed(text: "Başarıyla oturum açıldı", interaction: false, delay: 1)
                    let vc = HomeController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
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
