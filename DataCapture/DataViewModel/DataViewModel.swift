//
//  DataViewModel.swift
//  DataCapture
//
//  Created by Yermis Beltran on 6/03/22.
//

import Foundation

class DataViewModel {
    
    var data: DataModel?
    var didLoadData: (() -> Void)?
    
    let repository: DataRepositoryProtocol
    init(repository: DataRepositoryProtocol) {
        self.repository = repository
    }
    
    func getData() {
        repository.getData { result in
            switch result {
            case .success(let data):
                self.data = data
                self.didLoadData?()
            case .failure(let error):
                print(error)
            }
        }
    }
}
    
