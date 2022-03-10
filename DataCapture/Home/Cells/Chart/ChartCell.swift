//
//  ChartCell.swift
//  DataCapture
//
//  Created by Yermis Beltran on 9/03/22.
//

import UIKit
import Charts

class ChartCell: UITableViewCell, ChartViewDelegate {
    
    var pieChart = PieChartView()

    @IBOutlet weak var chartView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        pieChart.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pieChart.frame = CGRect(x: 0,
                                y: 0,
                                width: chartView.frame.size.width,
                                height: chartView.frame.size.height)
        
        pieChart.center = chartView.center
        chartView.addSubview(pieChart)
        
    }
    
    func showCell(with data: DataModel) {
        configChart(with: data)
    }
    
    func configChart( with data: DataModel) {
        
        var entries = [ChartDataEntry]()
        
        for i in 0..<data.questions[1].chartData.count {
            entries.append(ChartDataEntry(
                x: Double(data.questions[1].chartData[i].percetnage),
                y: Double(data.questions[1].chartData[i].percetnage)))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.material()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
}
