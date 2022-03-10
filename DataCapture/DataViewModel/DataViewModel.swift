//
//  DataViewModel.swift
//  DataCapture
//
//  Created by Yermis Beltran on 6/03/22.
//

import Foundation
import UIKit
import FirebaseRemoteConfig
import FirebaseDatabase

class DataViewModel {
    
    var data: DataModel?
    var nameText: String?
    
    var didLoadData: (() -> Void)?
    var remoteConfigLoaded: ((UIColor) -> Void)?
    
    let repository: DataRepositoryProtocol
    init(repository: DataRepositoryProtocol) {
        self.repository = repository
    }
    
    func saveUserName(userName: String) {
        repository.saveUserName(userName: userName)
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
    
    func remoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { [weak self] status, error in
            guard let self = self else { return }
            if status != .error {
                let changeHomeBackground = remoteConfig.configValue(forKey: "Home_Background_Color").stringValue
                
                DispatchQueue.main.async {
                    let colorConfig = ColorConfig()
                    self.remoteConfigLoaded?(colorConfig.hexStringToUIColor(hex: changeHomeBackground ?? "FFFFFF"))
                }
            }
        }
    }
    
    private func remoteConfigDefault() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 60
        
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.configSettings = settings
        remoteConfig.setDefaults(["Home_Background_Color" : NSString("#FFFFFF")])
    }
}
    
