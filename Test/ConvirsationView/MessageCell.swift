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
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with model: MessageCellModel) {
        let theme = ThemeManager().getTheme()
        
        backgroundColor = theme.backgroundColor
        selectionStyle = .none
        messageLabel.isHidden = true
        
        if model.senderId == UUIDGenerator.uuid {
            messageLabel.isHidden = true
            setupMessageLabels(label: myMessageLabel,
                              model: model,
                              color: theme.myMessageColor,
                              textColor: theme.textColor)

        } else {
            myMessageLabel.isHidden = true
            setupMessageLabels(label: messageLabel,
                              model: model,
                              color: theme.otherMessageColor,
                              textColor: theme.textColor)
        }
    }
    
    private func setupMessageLabels(label: PaddingLabel,
                                    model: MessageCellModel,
                                    color: UIColor,
                                    textColor: UIColor) {
        label.isHidden = false
        label.sizeToFit()
        label.lineBreakMode = .byWordWrapping
        label.text = model.content
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.numberOfLines = 0
        label.backgroundColor = color
        authorLabel.text = model.senderName
        dateLabel.text = Formatter.getDateOrTime(from: model.created)
        authorLabel.textColor = textColor
        dateLabel.textColor = textColor
    }
}
