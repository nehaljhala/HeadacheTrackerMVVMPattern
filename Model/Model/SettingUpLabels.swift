//
//  SettingUpLabels.swift
//  Headache Tracker
//
//  Created by Nehal Jhala on 3/16/22.
//

import Foundation
import UIKit

class SettingUpLabels{
    var label = UILabel()
    func setupLabelLayout(_ labelText : Float, _ rangeEnd: Int) -> String{
        guard labelText != 0.0 else{ return "" }
        let labelString:NSString = "\(String(describing: label.text))" as NSString
        var labelMutableString = NSMutableAttributedString()
        
        labelMutableString = NSMutableAttributedString(string: labelString as String)
        labelMutableString.setAttributes([NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20),NSAttributedString.Key.foregroundColor: UIColor.systemRed],range: NSMakeRange(0, 21))
        
        label.attributedText = labelMutableString
        return String("\(labelMutableString)")
    }
}
