//
//  DataModel.swift
//  DataCapture
//
//  Created by Yermis Beltran on 5/03/22.
//

import Foundation

// MARK: - Welcome
struct DataModel: Codable {
    let colors: [String]
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let total: Int
    let text: String
    let chartData: [ChartDatum]
}

// MARK: - ChartDatum
struct ChartDatum: Codable {
    let text: String
    let percetnage: Int
}
