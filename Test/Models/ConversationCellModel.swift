//
//  ConversationCellModel.swift
//  Test
//
//  Created by a.belyaev3 on 26.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import Firebase

struct ConversationCellModel {
    let identifier: String
    let name: String
    let lastMessage: String?
    let lastActivity: Timestamp?
}
