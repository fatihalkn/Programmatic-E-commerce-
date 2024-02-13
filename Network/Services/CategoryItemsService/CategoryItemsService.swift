//
//  CategoriesManager.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import Foundation

protocol CategoryItemsServiceProtocol {
    func getElectronicsProducts(completion: @escaping (([Product], Error?) -> ()))
    func getJeweleryProducts(completion: @escaping (([Product], Error?) -> ()))
    func getMensclothingProducts(completion: @escaping (([Product], Error?) -> ()))
    func getWomensclothingProducts(completion: @escaping (([Product], Error?) -> ()))
}

class CategoryItemsService {
    static let shared = CategoryItemsService()
    
    //MARK: - Private Init
    private init() { }
    
    
}

//MARK: - CategoryItemsServiceProtocol
extension CategoryItemsService: CategoryItemsServiceProtocol {
    func getElectronicsProducts(completion: @escaping (([Product], Error?) -> ())) {
        NetworkManager.shared.request(type: [Product].self, url: CategoryEndpoint.electronics.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("Error in getElectronicsProducts: \(error)")
                completion([], error)
            }
        }
    }
    
    func getJeweleryProducts(completion: @escaping (([Product], Error?) -> ())) {
        NetworkManager.shared.request(type: [Product].self, url: CategoryEndpoint.jewelery.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("Error in getJeweleryProducts: \(error)")
                completion([], error)
            }
        }
    }
    
    func getMensclothingProducts(completion: @escaping (([Product], Error?) -> ())) {
        NetworkManager.shared.request(type: [Product].self, url: CategoryEndpoint.mensclothing.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("Error in getMensclothingProducts: \(error)")
                completion([], error)
            }
        }
    }
    
    func getWomensclothingProducts(completion: @escaping (([Product], Error?) -> ())) {
        NetworkManager.shared.request(type: [Product].self, url: CategoryEndpoint.womensclothing.path, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                print("Error in getWomensclothingProducts: \(error)")
                completion([], error)
            }
        }
    }
}
