//
//  NetworkManager.swift
//  E-Commerce
//
//  Created by Fatih on 12.02.2024.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type, url: String, method: HTTPmethods, completion: @escaping((Result<T, ErrorTypes>)) -> ()) {
        let session = URLSession.shared
        if let url = URL(string: url) {
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            
            let dataTask = session.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.genaralError))
                } else if let data = data {
                    self.handleResponse(data: data) { response in
                        completion(response)
                    }
                    
                } else {
                    completion(.failure(.invalidURL))
                }
            }
            dataTask.resume()
            
        }
        
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data,completion: @escaping((Result<T, ErrorTypes>)) -> ()) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
        } catch {
            completion(.failure(.invalidData))
        }
    }
}
