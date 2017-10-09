//
//  Extension.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 05.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class var aquamarine: UIColor {
        return UIColor(red: 72.0 / 255.0, green: 209.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0)
    }
    class var aquamarineDark: UIColor {
        return UIColor(red: 54.0 / 255.0, green: 81.0 / 255.0, blue: 94.0 / 255.0, alpha: 1.0)
    }

}


extension Int
{
    static func random(range: ClosedRange<Int> ) -> Int
    {
        var offset = 0
        
        if range.lowerBound < 0   // allow negative ranges
        {
            offset = abs(range.lowerBound)
        }
        
        let mini = UInt32(range.lowerBound + offset)
        let maxi = UInt32(range.upperBound   + offset)
        
        return Int(mini + arc4random_uniform(maxi - mini)) - offset
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                                 action: #selector(dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

enum UILabelTextPositions {
    
    case top
    case middle
    case bottom
    
}

extension UILabel{
    func makeLabelTextPosition(position: UILabelTextPositions) {
        let rect = self.textRect(forBounds: bounds, limitedToNumberOfLines: 0)
        
        switch position {
        case .top:
            self.frame = CGRect(x: bounds.origin.x+5, y: bounds.origin.y, width: rect.size.width, height: rect.size.height)
            
        case .middle:
            self.frame = CGRect(x: bounds.origin.x+5, y: bounds.origin.y + (bounds.size.height - rect.size.height) / 2, width: rect.size.width, height: rect.size.height);

        case .bottom:
            self.frame = CGRect(x: bounds.origin.x+5, y: bounds.origin.y + (bounds.size.height - rect.size.height), width: rect.size.width, height: rect.size.height);

        
        }
    }
}
