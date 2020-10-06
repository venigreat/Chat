//
//  MessageCell.swift
//  Test
//
//  Created by a.belyaev3 on 02.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell, ConfigurableView {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    
    func configure(with model: MessageCellModel) {
        backgroundColor = .gray
        selectionStyle = .none
        messageLabel.text = model.text
        messageLabel.layer.masksToBounds = true
        messageLabel.layer.cornerRadius = 5
        let textWidth = messageLabel.intrinsicContentSize.width
        let viewWidth = frame.width
        messageLabel.numberOfLines = 0
        messageLabel.preferredMaxLayoutWidth = CGFloat.minimum(textWidth, viewWidth * 0.7)
        
        if model.isMy {
            messageLabel.backgroundColor = .white
            rightConstraint.isActive = false
        } else {
            leftConstraint.isActive = false
        }
    }
    
}
