//
//  HomeViewController.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: DataViewModel = DataViewModel(repository: DataRepository(httpClient: AFHTTPClient()))
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var dataTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCells()
        configTable()
        
        activityIndicator.isHidden = false
        viewModel.remoteConfigLoaded = { [weak self] color in
            self?.activityIndicator.isHidden = true
            self?.view.backgroundColor = color
        }
        
        activityIndicator.isHidden = false
        viewModel.didLoadData = { [weak self] in
            self?.activityIndicator.isHidden = true
            self?.dataTable.reloadData()
        }
        viewModel.remoteConfig()
        viewModel.getData()
    }
    
    private func configCells() {
        dataTable.register(UINib(nibName: "nameCell", bundle: Bundle.main), forCellReuseIdentifier: "nameCell")
        dataTable.register(UINib(nibName: "photoCaptureCell", bundle: Bundle.main), forCellReuseIdentifier: "photoCaptureCell")
        dataTable.register(UINib(nibName: "DashBoardCell", bundle: Bundle.main), forCellReuseIdentifier: "DashBoardCell")
        dataTable.register(UINib(nibName: "ChartCell", bundle: Bundle.main), forCellReuseIdentifier: "ChartCell")
    }
    
    private func configTable() {
        dataTable.dataSource = self
        dataTable.delegate = self
    }

    @IBAction func SendInfoAction(_ sender: Any) {
        viewModel.saveUserName(userName: viewModel.nameText ?? "")
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! nameCell
            cell.configCell(dataViewModel: viewModel)
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
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartCell
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

