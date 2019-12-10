//
//  WebService.swift
//  Moon Bucks
//
//  Created by Michael Grant on 11/27/19.
//  Copyright © 2019 Michael Grant. All rights reserved.
//

import Foundation

struct Resource<T: Codable> {
    
    let url: URL
}

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
}
class WebService {
    
    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
           
            guard let data = data, error == nil else {
                
                completion(.failure(.domainError))
                return
            }
            
            let result = try? JSONDecoder().decode(T.self, from: data)
            
            if let result = result {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
                
            } else {
                completion(.failure(.decodingError))
                
            }
            
        }.resume()
        
    }
}
