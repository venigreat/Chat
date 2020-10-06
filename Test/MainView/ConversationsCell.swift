//
//  ConversationsCell.swift
//  Test
//
//  Created by a.belyaev3 on 29.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ConversationsCell: UITableViewCell, ConfigurableView {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with model: ConversationCellModel) {
        nameLabel.text = model.name
        messageLabel.text = (model.message != nil) ? model.message : "No messages yet"
        if Date().hours(from: model.date) > 24 {
            dateLabel.text = Formatter.getDate(from: model.date)
        } else {
             dateLabel.text = Formatter.getTime(from: model.date)
        }
        if model.isOnline {
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 0.7436857877, alpha: 1)
        } else {
            backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        if model.hasUnreadMessages {
            messageLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
        } else {
            messageLabel.font = UIFont.systemFont(ofSize: 16.0)
        }
    }
}
