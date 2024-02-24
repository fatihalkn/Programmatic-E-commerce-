//
//  UserProfileController.swift
//  E-Commerce
//
//  Created by Fatih on 15.02.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import FirebaseFirestore

class UserProfileController: UIViewController  {
    
    let db = Firestore.firestore()
    var currentUSer: User?
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.backgroundColor = .clear
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .main
        return imageView
    }()
    

    let userNameTextField = CustomTextFields(isSecureText: false,
                                             placeHolder: "",
                                             leftImage: UIImage(named: "person")!,userName: "fatihalkan@gmail.com", password: nil)
    
    let emailTextField = CustomTextFields(isSecureText: false,
                                          placeHolder: "",
                                          leftImage: UIImage(named: "mail")!,userName: nil,password: nil)
    
    let UploadButton = CustomButtons(title: "Upload Photo",
                                    titleColor: .white,
                                    font: .systemFont(ofSize: 17),
                                    backroundColor: .main)
    
    let LogoutButton = CustomButtons(title: "Log-Out",
                                    titleColor: .white,
                                    font: .systemFont(ofSize: 17),
                                    backroundColor: .main)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupButtonsTarget()
        getUserInfo()
        profileImageView.isUserInteractionEnabled = true
        let getureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ClickedUploadButton))
        profileImageView.addGestureRecognizer(getureRecognizer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupRadius()
    }
    
    func setupButtonsTarget() {
        UploadButton.addTarget(self, action: #selector(ClickedUploadButton), for: .touchUpInside)
        LogoutButton.addTarget(self, action: #selector(ClickedLogoutButton), for: .touchUpInside)
        
    }
    
    @objc func ClickedUploadButton() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true)
    }
    
    @objc func ClickedLogoutButton() {
        do {
            try Auth.auth().signOut()
            let loginVC = LoginController()
            let nav = UINavigationController(rootViewController: loginVC)
            UIApplication.shared.windows.first?.rootViewController = nav // Root view controller'ı değiştir

           
            
        } catch {
            print(error.localizedDescription)
            
        }
        
    }
    
    
    func setupRadius() {
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height / 2
        profileImageView.layer.masksToBounds = true
        
        userNameTextField.layer.cornerRadius = userNameTextField.frame.height / 2
        userNameTextField.layer.masksToBounds = true
        
        emailTextField.layer.cornerRadius = emailTextField.frame.height / 2
        emailTextField.layer.masksToBounds = true
        
        UploadButton.layer.cornerRadius = UploadButton.frame.height / 2
        UploadButton.layer.masksToBounds = true
        
        LogoutButton.layer.cornerRadius = LogoutButton.frame.height / 2
        LogoutButton.layer.masksToBounds = true
        
        
    }
    
    
    func setupUI() {
        view.addSubview(profileImageView)
        view.addSubview(userNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(UploadButton)
        view.addSubview(LogoutButton)
        profileImageViewConstrain()
        userNameTextFieldConstrain()
        emailTextFieldConstrain()
        saveButtonConstrain()
        logOutButtonCostrain()
        
    }
    
  
}

//MARK: - Photo-Picker
extension UserProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            upPhoto(selectedImage)
        }
        picker.dismiss(animated: true, completion: nil)
        
        
       }
    
    func upPhoto(_ image: UIImage) {
        showLoading(text: nil, interaction: false)
        let storege = Storage.storage()
        let storageRef = storege.reference()
        let uid = currentUSer?.uid ?? "Kullanıcı bulunamadı"
        let mediaFolder = storageRef.child("Image").child(uid)
        
        if let data = image.jpegData(compressionQuality: 0.5) {
            let imageViewRef = mediaFolder.child("\(uid).jpg")
            imageViewRef.putData(data, metadata: nil) { metadata, error in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    self.getUserPhoto()
                }
            }
        }
    }
    
    func getUserPhoto() {
        if let uid = currentUSer?.uid {
            let storege = Storage.storage()
            let storegeRef = storege.reference().child("Image/\(uid)")
            storegeRef.listAll { result , error in
                guard let ref = result?.items.first else { return }
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    ref.downloadURL { url, error in
                        if let error = error {
                            print(error.localizedDescription)
                        } else if let imageURL = url {
                            self.profileImageView.sd_setImage(with: imageURL,completed: nil)
                            self.removeLoading()
                        
                        }
                    }
                }
            }
        }
    }
    
    func updateTextField() {
        emailTextField.text = currentUSer?.email
        
        if let uid = currentUSer?.uid {
            let userRef = db.collection("Users").document(uid)
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    let userName = document["userName"] as? String
                    self.userNameTextField.text = userName
                } else {
                    print(error?.localizedDescription ?? "Kullanıocı asfdaşskndfhal")
                }
            }
        }
    }
    
    func getUserInfo() {
        if let user = Auth.auth().currentUser {
            currentUSer = user
            updateTextField()
        }
        getUserPhoto()
    }
    
    }
    


//MARK: - Cofigure Constraim

extension UserProfileController {
    
    func profileImageViewConstrain() {
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileImageView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            profileImageView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor,multiplier: 0.5),
            profileImageView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5)
        ])
        
    }
    
    func userNameTextFieldConstrain() {
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 15),
            userNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            userNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func emailTextFieldConstrain() {
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor,constant: 15),
            emailTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            emailTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            emailTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func saveButtonConstrain() {
        NSLayoutConstraint.activate([
            UploadButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor,constant: 15),
            UploadButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 30),
            UploadButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -30),
            UploadButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func logOutButtonCostrain() {
        NSLayoutConstraint.activate([
            LogoutButton.topAnchor.constraint(equalTo: UploadButton.bottomAnchor, constant: 15),
            LogoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            LogoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            LogoutButton.heightAnchor.constraint(equalToConstant: 50)

        ])

    }
}


