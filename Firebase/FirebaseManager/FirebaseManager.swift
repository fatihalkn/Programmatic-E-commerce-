//
//  FirebaseManager.swift
//  E-Commerce
//
//  Created by Fatih on 11.02.2024.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseManager {
    static let shared = FirebaseManager()
    
    //MARK: - Referance
    let auth = Auth.auth()
    let db = Firestore.firestore()
    
    var UserID: String? {
        return auth.currentUser?.uid
    }
    
    private init() { }
}

//MARK: -  Auth Methods

extension FirebaseManager {
    
    func signUpUser(with email: String, password: String, completion: @escaping ((Result<String, Error>) -> Void)) {
        auth.createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
            }
            
            let userID = authResult?.user.uid
            completion(.success(userID ?? "boş"))
        }
    }
    
    func signInUser(with email: String, password: String, completion: @escaping ((Result<Void, Error>) -> Void)) {
        auth.signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            completion(.success(()))
        }
        
    }
    
}

//MARK: - Data Base Methods

extension FirebaseManager {
    
    func creatUserDociment(userDocimentModel: FirebaseUserDocumentModel, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let fields: [String: Any] = [
            "userEmail": userDocimentModel.userEmail,
            "userName": userDocimentModel.userName,
            "userPassword": userDocimentModel.userPassword,
            "userID": userDocimentModel.userID
        ]
        db.collection("Users").document(userDocimentModel.userID).setData(fields) { error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            completion(.success(()))
        }
        
    }
}

