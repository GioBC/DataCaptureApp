//
//  HomeViewController.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit
import FirebaseRemoteConfig
import FirebaseDatabase

class HomeViewController: UIViewController {
    
    var colorConfig = ColorConfig()
    var viewModel: DataViewModel = DataViewModel(repository: DataRepository(httpClient: AFHTTPClient()))
    
    var db: DatabaseReference!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCells()
        configTable()
        // Remote config Firebase
        remoteConfig()
        db = Database.database().reference()
        activityIndicator.isHidden = false
        viewModel.didLoadData = { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.dataTable.reloadData()
        }
        viewModel.getData()
    }
    
    private func remoteConfig() {
        let remoteConfig = RemoteConfig.remoteConfig()
        remoteConfig.fetchAndActivate { status, error in
            if status != .error {
                let changeHomeBackground = remoteConfig.configValue(forKey: "Home_Background_Color").stringValue
                
                DispatchQueue.main.async {
                    self.view.backgroundColor = self.colorConfig.hexStringToUIColor(hex: changeHomeBackground ?? "FFFFFF")
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
    
    private func configCells() {
        dataTable.register(UINib(nibName: "nameCell", bundle: Bundle.main), forCellReuseIdentifier: "nameCell")
        dataTable.register(UINib(nibName: "photoCaptureCell", bundle: Bundle.main), forCellReuseIdentifier: "photoCaptureCell")
        dataTable.register(UINib(nibName: "DashBoardCell", bundle: Bundle.main), forCellReuseIdentifier: "DashBoardCell")
    }
    
    private func configTable() {
        dataTable.dataSource = self
        dataTable.delegate = self
    }

    @IBAction func SendInfoAction(_ sender: Any) {
        db.child("names").setValue(["userName" : "name"])
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! nameCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "photoCaptureCell", for: indexPath) as! photoCaptureCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DashBoardCell", for: indexPath) as! DashBoardCell
            if let data = viewModel.data {
                cell.showCell(with: data)
                cell.selectionStyle = .none
            }
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            let nextViewController = CameraViewController(nibName: "CameraViewController", bundle: .main)
            self.present(nextViewController, animated: true)
        default:
            break
        }
    }
}

