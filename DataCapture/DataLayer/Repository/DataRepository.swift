//
//  DataRepository.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import Foundation

typealias DataModelResult = DataResult<DataModel>
                                        
protocol DataRepositoryProtocol {
    func getData(completion:@escaping (DataModelResult) -> Void)

}

class DataRepository: DataRepositoryProtocol {
    
    let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func getData(completion: @escaping (DataModelResult) -> Void) {
        let url = Constants.url
        httpClient.request(url: url, completion: completion)
    }
}
