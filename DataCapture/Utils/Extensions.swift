//
//  Extensions.swift
//  DataCapture
//
//  Created by Yermis Beltran on 6/03/22.
//

import Foundation
import UIKit

struct ColorConfig {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension String {
    func validName() -> Bool {
    do {
        let regex = try NSRegularExpression(pattern: ".[^A-Za-zÀ-ü ].", options: [])
        return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) == nil
    } catch {
        return false
        }
    }
    func validTextOnlyCharacters() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".[^A-Za-z ].", options: [])
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) == nil
        } catch {
            return false
        }
    }
    func validTextOnlyNumbers() -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: ".[^0-9].", options: [])
            return regex.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) == nil
        } catch {
            return false
        }
    }
}
