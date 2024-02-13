//
//  NetworkHelper.swift
//  E-Commerce
//
//  Created by Fatih on 12.02.2024.
//

import Foundation

enum HTTPmethods: String {
    case get = "GET"
    case post = "POST"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid URL"
    case genaralError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
    
    let baseURL = "https://fakestoreapi.com/"
    
    
    func requestUrl(url: String) -> String {
        baseURL + url
    }
    
    func requestAllProducts() -> String {
        baseURL + "products"
    }
    
    func requestDetailProducts(id: Int) -> String {
        baseURL + "\(ProductDetailEndpoint.detail.rawValue)" + "\(id)"
    }
    
    func requestCategoryItems(categoryType: CategoryEndpoint) -> String {
        baseURL + categoryType.rawValue
    }
}


