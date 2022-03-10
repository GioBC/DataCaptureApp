//
//  DataRepository.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import Foundation
import FirebaseRemoteConfig
import FirebaseDatabase

typealias DataModelResult = DataResult<DataModel>
                                        
protocol DataRepositoryProtocol {
    func getData(completion:@escaping (DataModelResult) -> Void)
    func saveUserName(userName: String)
}

class DataRepository: DataRepositoryProtocol {
    
    let httpClient: HTTPClient
    let db: DatabaseReference
    
    init(httpClient: HTTPClient,
         db: DatabaseReference = Database.database().reference()) {
        self.httpClient = httpClient
        self.db = db
    }
    
    func getData(completion: @escaping (DataModelResult) -> Void) {
        let url = Constants.url
        httpClient.request(url: url, completion: completion)
    }
    
    func saveUserName(userName: String) {
        db.child("names").setValue(["userName" : userName])
    }
}
