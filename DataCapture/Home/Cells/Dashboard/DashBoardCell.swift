//
//  DashBoardCell.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import UIKit
import Charts

class DashBoardCell: UITableViewCell {
    
    let colorConfig = ColorConfig()
    
    //Outlet Section 1

    @IBOutlet weak var questionOneLabel: UILabel!
    @IBOutlet weak var yesOneAnswer: UILabel!
    @IBOutlet weak var noOneAnswer: UILabel!
    @IBOutlet weak var yesOneProgressBar: UIProgressView!
    @IBOutlet weak var noOneProgressBar: UIProgressView!
    @IBOutlet weak var dashBoardView: UIView!
    
    //Outlet Section 2
    @IBOutlet weak var questionTwoLabel: UILabel!
    //Progress Bar
    @IBOutlet weak var elektraProgressBar: UIProgressView!
    @IBOutlet weak var bancoAztecaProgressBar: UIProgressView!
    @IBOutlet weak var netoProgressBar: UIProgressView!
    @IBOutlet weak var upaxProgressBar: UIProgressView!
    @IBOutlet weak var otherProgressBar: UIProgressView!
    @IBOutlet weak var dragonProgressBar: UIProgressView!
    //Values
    @IBOutlet weak var elextraValueLabel: UILabel!
    @IBOutlet weak var bAztecaValueLabel: UILabel!
    @IBOutlet weak var netoValueLabel: UILabel!
    @IBOutlet weak var upaxValueLabel: UILabel!
    @IBOutlet weak var dragonValueLabel: UILabel!
    @IBOutlet weak var otherValueLabel: UILabel!
    
    @IBOutlet weak var elektraLabel: UILabel!
    @IBOutlet weak var bancoAztecaLabel: UILabel!
    @IBOutlet weak var netoLabel: UILabel!
    @IBOutlet weak var upaxLabel: UILabel!
    @IBOutlet weak var dragonLabel: UILabel!
    @IBOutlet weak var otherLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func showCell(with data: DataModel) {
        // First Info
        configFirstSection(with: data)
        //Second Info
        configSecondSection(with: data)
    }
    
    func configFirstSection(with data: DataModel) {
        questionOneLabel.text = data.questions[0].text
        yesOneAnswer.text = data.questions[0].chartData[0].text + ": \(data.questions[0].chartData[0].percetnage) %"
        //yesOneAnswer.textColor = hexStringToUIColor(hex: data.colors[2])
        yesOneAnswer.textColor = colorConfig.hexStringToUIColor(hex: data.colors[2])
        noOneAnswer.text = data.questions[0].chartData[1].text + ": \(data.questions[0].chartData[1].percetnage) %"
        noOneAnswer.textColor = colorConfig.hexStringToUIColor(hex: data.colors[3])
        
        
        yesOneProgressBar.progress = Float(data.questions[0].chartData[0].percetnage) / 100
        noOneProgressBar.progress = Float(data.questions[0].chartData[1].percetnage) / 100
        // Progress color
        yesOneProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[2])
        noOneProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[3])
    }
    
    func configSecondSection(with data: DataModel) {
        //Question Section
        questionTwoLabel.text = data.questions[1].text
        //Percetnage Values
        elextraValueLabel.text = "\(data.questions[1].chartData[0].percetnage)%"
        bAztecaValueLabel.text = "\(data.questions[1].chartData[1].percetnage)%"
        netoValueLabel.text = "\(data.questions[1].chartData[2].percetnage)%"
        upaxValueLabel.text = "\(data.questions[1].chartData[3].percetnage)%"
        dragonValueLabel.text = "\(data.questions[1].chartData[4].percetnage)%"
        otherValueLabel.text = "\(data.questions[1].chartData[5].percetnage)%"
        //Progressbar Value
        elektraProgressBar.progress = Float(data.questions[1].chartData[0].percetnage) / 100
        bancoAztecaProgressBar.progress = Float(data.questions[1].chartData[1].percetnage) / 100
        netoProgressBar.progress = Float(data.questions[1].chartData[2].percetnage) / 100
        upaxProgressBar.progress = Float(data.questions[1].chartData[3].percetnage) / 100
        dragonProgressBar.progress = Float(data.questions[1].chartData[4].percetnage) / 100
        otherProgressBar.progress = Float(data.questions[1].chartData[5].percetnage) / 100
        //Progress bar Color
        elektraProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[2])
        bancoAztecaProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[3])
        netoProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: "FFC352")
        upaxProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[4])
        dragonProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: "FFFF52")
        otherProgressBar.progressTintColor = colorConfig.hexStringToUIColor(hex: data.colors[0])
    }
}
