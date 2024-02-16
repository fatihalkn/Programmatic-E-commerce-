//
//  CategoriesHelper.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
// let baseURL = "https://fakestoreapi.com/"

import Foundation


enum CategoryEndpoint: String {
    case electronics = "products/category/electronics"
    case jewelery = "products/category/jewelery"
    case mensclothing = "products/category/men's%20clothing"
    case womensclothing = "products/category/women's%20clothing"
    
    var path: String {
        switch self {
        case .electronics:
            return NetworkHelper.shared.requestUrl(url: CategoryEndpoint.electronics.rawValue)
        case .jewelery:
            return NetworkHelper.shared.requestUrl(url: CategoryEndpoint.jewelery.rawValue)
        case .mensclothing:
            return NetworkHelper.shared.requestUrl(url: CategoryEndpoint.mensclothing.rawValue)
        case .womensclothing:
            return NetworkHelper.shared.requestUrl(url: CategoryEndpoint.womensclothing.rawValue)
        }
    }
    
}


