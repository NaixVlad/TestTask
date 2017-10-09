//
//  CardCell.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 07.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    
    @IBInspectable
    var shadowColor: UIColor = UIColor.gray {
        didSet{
            layer.borderColor = shadowColor.cgColor
        }
    }
    
    
    @IBInspectable
    public var shadowRadius: CGFloat = 2.0 {
        didSet {
            layer.shadowRadius = shadowRadius
        }
    }
    
    @IBInspectable
    public var shadowOpacity: Float = 1.0 {
        didSet {
            layer.shadowOpacity = shadowOpacity
        }
    }
    
    @IBInspectable
    public var shadowOffset: CGSize = CGSize(width: 0, height: 2.0) {
        didSet {
            layer.shadowOffset = shadowOffset
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.shadowPath = UIBezierPath(roundedRect:self.bounds, cornerRadius:self.contentView.layer.cornerRadius).cgPath
        layer.masksToBounds = false
        
    }
    
}
