//
//  FirebaseModel.swift
//  E-Commerce
//
//  Created by Fatih on 11.02.2024.
//

import Foundation

struct FirebaseUserDocumentModel: Codable {
    var userID : String
    var userName: String
    var userEmail: String
    var userPassword: String
    var userFovoriteProducts: [Product]
    var userTappedProducts: [String]
}
