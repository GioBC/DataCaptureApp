//
//  AFHttpClient.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import Foundation
import Alamofire

class AFHTTPClient: HTTPClient {
        
    func parse<T>(data: Data, type: T.Type, completion: @escaping (DataResult<T>) -> Void) where T: Codable {
        do {
            let json = try JSONDecoder().decode(T.self, from: data)
            completion(.success(json))
            
        } catch {
            print("[Error parsing]")
            print(error)
            completion(.failure(.errorParser))
        }
    }
    
    func request<T: Codable>(url: String, completion: @escaping (DataResult<T>) -> Void) {
        AF.request(url).response { response in
            switch response.result {
            case .success(let data):
                guard let data = data else {
                    completion(.failure(.errorParser))
                    return
                }
                self.parse(data: data, type: T.self, completion: completion)
            case .failure:
                completion(.failure(.serviceError))
            }
        }.validate()
        
    }
}
