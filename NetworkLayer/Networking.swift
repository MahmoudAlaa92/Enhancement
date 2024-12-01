//
//  Networking.swift
//  Enhancement
//
//  Created by Mahmoud Alaa on 30/11/2024.
//

import Foundation
import Alamofire

class Networking {
    
    static var share = Networking()
    
    enum ErrorTestCase: Error {
        case invalidURL
    }
    
    func fetchData<T: Decodable> (url: String, classType: T.Type, completion: @escaping (Result<T? ,Error>) -> Void) {
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }

    }
    
    // Fetch Products
    func fetchProducts(completion: @escaping (Result<[Product]?, Error>) -> Void) {
        
        let url = "https://fakestoreapi.com/products"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: [Product].self) { response in
            switch response.result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
  // Fetch Carts
    func fetchCarts(completion: @escaping (Result<[Carts]?, Error>) -> Void) {
        
        let url = "https://fakestoreapi.com/carts"
        
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   headers: nil)
        .responseDecodable(of: [Carts].self) { response in
            switch response.result {
            case .success(let carts):
                completion(.success(carts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}

struct Product: Codable {
    var id: Int?
    var titlee: String?
    var price: Double?  // Ensure it's String if the API uses strings for prices
    var category: String?
    var description: String?
    var image: String?
    var rating: Rating?
    
    enum CodingKeys: String, CodingKey {
        case id
        case titlee = "title"
        case price
        case category
        case description
        case image
        case rating
    }
}

struct Rating: Codable {
    var rate: Double?
    var  count: Int?
}


struct Carts: Decodable {
    var id: Int?
    var userId: Int?
}
