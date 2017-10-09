//
//  RoundImageView.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 06.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import UIKit

class RoundImageView: UIImageView {

    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            layer.borderColor = borderColor.cgColor
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.masksToBounds = true
    }
}
