//
//  HomeNavProfileView.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SDWebImage

final class HomeNavProfileView: UIView {
    
    static let shared = HomeNavProfileView()
    
    let db  = Firestore.firestore()
    var currentUser: User?
    
    //MARK: - Creating UI Elements
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        return imageView
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Hi, Fatih"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.numberOfLines = 1
        label.text = "Let's go shopping"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Init Methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.masksToBounds = true
    }
    
    func updateTextField() {
        titleLabel.text = currentUser?.email
        
        if let uid = currentUser?.uid {
            let userRef = db.collection("Users").document(uid)
            userRef.getDocument { document, error in
                if let document = document, document.exists {
                    let userName = document["userName"] as? String
                    self.titleLabel.text = userName
                } else {
                    print(error?.localizedDescription ?? "Kullanıocı asfdaşskndfhal")
                }
            }
        }
    }
    
    func getUserInfo() {
        if let user = Auth.auth().currentUser {
            currentUser = user
            updateTextField()
        }
        getUserPhoto()
    }
    
    func getUserPhoto() {
        if let uid = currentUser?.uid {
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
                            
                        
                        }
                    }
                }
            }
        }
    }
}

//MARK: - SetupUI
extension HomeNavProfileView {
    private func setupUI() {
        backgroundColor = .clear
        
        addSubview(profileImageView)
        addSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(subTitleLabel)
        
        NSLayoutConstraint.activate([
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            profileImageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            profileImageView.widthAnchor.constraint(equalTo: self.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            labelStackView.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            labelStackView.heightAnchor.constraint(lessThanOrEqualTo: profileImageView.heightAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5),
            labelStackView.trailingAnchor.constraint(lessThanOrEqualTo: self.trailingAnchor)
        ])
    }
}


