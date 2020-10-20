//
//  MessageCell.swift
//  Test
//
//  Created by a.belyaev3 on 02.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, ConfigurableView {

    @IBOutlet weak var messageLabel: PaddingLabel!
    @IBOutlet weak var myMessageLabel: PaddingLabel!
    
    func configure(with model: MessageCellModel) {
        let theme = ThemeManager().getTheme()
        
        backgroundColor = theme.backgroundColor
        selectionStyle = .none
        
        if model.isMy {
            messageLabel.isHidden = true
            setupMessageLabel(label: myMessageLabel,
                              text: model.text,
                              color: theme.myMessageColor)
            
        } else {
            myMessageLabel.isHidden = true
            setupMessageLabel(label: messageLabel,
                              text: model.text,
                              color: theme.otherMessageColor)
        }
    }
    
    private func setupMessageLabel(label: PaddingLabel, text: String, color: UIColor) {
        label.isHidden = false
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.text = text
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.backgroundColor = color
    }
}
