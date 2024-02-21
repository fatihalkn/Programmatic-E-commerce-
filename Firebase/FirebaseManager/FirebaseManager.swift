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
    
    var userID: String? {
        return auth.currentUser?.uid
    }
    
    private init() { }
}

//MARK: -  Auth Methods

extension FirebaseManager {
    
    func signUpUser(with email: String, password: String, completion: @escaping ((Result<String?, Error>) -> Void)) {
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
    
    func creatUserDocument(userDocumentModel: FirebaseUserDocumentModel, completion: @escaping ((Result<Void, Error>) -> Void)) {
        
        let fields: [String: Any] = [
            "userEmail": userDocumentModel.userEmail,
            "userName": userDocumentModel.userName,
            "userPassword": userDocumentModel.userPassword,
            "userID": userDocumentModel.userID,
            "userFovoriteProducts": userDocumentModel.userFovoriteProducts,
            "userTappedProducts": userDocumentModel.userTappedProducts
        ]
        db.collection("Users").document(userDocumentModel.userID ).setData(fields) { error in
            
            if let error = error {
                completion(.failure(error))
            }
            
            completion(.success(()))
        }
        
    }
    
    
    func updateUserTapperdProduts(userID:String, productTitle: String) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                var tappedProducts = userDocument.userTappedProducts
                if tappedProducts.contains(where: {$0 == productTitle}) {
                    return
                }
                tappedProducts.append(productTitle)
                let userDocumentRef = Firestore.firestore().collection("Users").document(userID)
                userDocumentRef.updateData(["userTappedProducts": tappedProducts]) { error in
                    if error != nil {
                        return
                    }
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func updateFavoriteProduct(userID: String, product: Product, willAdd: Bool,completion: @escaping ((Result<Void, Error>) -> Void)) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocument):
                var favoriteProduct = userDocument.userFovoriteProducts
                if willAdd {
                    if favoriteProduct.contains(where: {$0 == product.id}) {
                        return
                    }
                    favoriteProduct.append(product.id ?? 0)
                } else {
                    if let indexToDelete = favoriteProduct.firstIndex(where: {$0 == product.id }) {
                        favoriteProduct.remove(at: indexToDelete)
                    }
                }
                
                let willUpdateFields = favoriteProduct
                let userDocumentRef = Firestore.firestore().collection("Users").document(userID)
                userDocumentRef.updateData(["userFovoriteProducts": willUpdateFields]) { error in
                    if let error {
                        completion(.failure(error))
                    }
                    
                    completion(.success(()))
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    func fetchUserDocument(completion: @escaping ((Result<FirebaseUserDocumentModel, Error>) -> Void))  {
        
        guard let userID = Auth.auth().currentUser?.uid else {
            let error = NSError(domain: "Kullanıcı bulunamadı", code: 3131)
            completion(.failure(error))
            return
        }
        
        let userDocumentRef = Firestore.firestore().collection("Users").document(userID)
        userDocumentRef.getDocument { documentSnapShot, error in
            if let error {
                completion(.failure(error))
            }
            
            let documentSnapShotDictionary = documentSnapShot?.data()
            let jsonDecoder = JSONDecoder()
            if let documentSnapShotDictionary {
                do {
                    let documentSnapShotData = try JSONSerialization.data(withJSONObject: documentSnapShotDictionary)
                    let decodedDocumentSnapShot = try jsonDecoder.decode(FirebaseUserDocumentModel.self, from: documentSnapShotData)
                    completion(.success(decodedDocumentSnapShot))
                } catch {
                    completion(.failure(error))
                }
            }
        }
    }
    
  
    
    
    func checkIsProductsFavorite(produtcs:Product?, completion: @escaping ((_ isFavorite: Bool)-> Void)) {
        fetchUserDocument { result in
            switch result {
            case .success(let userDocumentData):
                let favoriteProducts = userDocumentData.userFovoriteProducts
                if favoriteProducts.contains(where: {$0 == produtcs?.id }) {
                    completion(true)
                } else {
                    completion(false)
                }
            case .failure(let _):
                completion(false)
            }
        }
        
    }
    
}
