//
//  ProductDetailService.swift
//  E-Commerce
//
//  Created by Fatih on 13.02.2024.
//

import Foundation

protocol ProductDetailServiceProtocol {
    func getProductsDetail(id:Int, completion: @escaping ((Product?, Error?) -> ()))
}

class ProductDetailService {
    
    static let shared = ProductDetailService()
    
    //MARK: - Private Init
    private init() { }
    
    
}

//MARK: - ProductDetailServiceProtocol
extension ProductDetailService: ProductDetailServiceProtocol {
    func getProductsDetail(id:Int, completion: @escaping ((Product?, Error?) -> ())) {
        let detailRequestURL = NetworkHelper.shared.requestDetailProducts(id: id)
        NetworkManager.shared.request(type: Product.self, url: detailRequestURL, method: .get) { response in
            switch response {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        
    }
}
