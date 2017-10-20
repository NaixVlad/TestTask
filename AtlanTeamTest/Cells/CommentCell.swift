//
//  CommentCell.swift
//  AtlanTeamTest
//
//  Created by Vladislav Andreev on 09.10.17.
//  Copyright © 2017 Vladislav Andreev. All rights reserved.
//

import UIKit

protocol CommentCellDelegate: class {
    func submitCommentCellAtIndexPath(_ indexPath: IndexPath)
}

class CommentCell: CardCell, UITextFieldDelegate {
    
    weak var delegate: CommentCellDelegate?
    var indexPath: IndexPath!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var bodyLabel: UILabel!
    
    @IBAction func submitButtonAction(_ sender: UIButton) {

        self.delegate?.submitCommentCellAtIndexPath(indexPath)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
    
}
