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
        messageLabel.text = model.lastMessage
        if let timeInterval = model.lastActivity {
            dateLabel.text = Formatter.getDateOrTime(from: timeInterval.dateValue())
        } else {
            dateLabel.text = nil
        }
    }
}
