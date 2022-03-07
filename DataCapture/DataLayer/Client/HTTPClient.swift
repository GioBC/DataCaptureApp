//
//  HTTPClient.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import Foundation

typealias DataResult<Success> = Swift.Result<Success, HTTPClientError>

protocol HTTPClient {
    func request<T: Codable>(url: String, completion: @escaping (DataResult<T>) -> Void)
}

enum HTTPClientError: Swift.Error {
    case connectivity
    case serviceError
    case errorParser
    case badURL
    case coreDataError
    case emptyResults
}
