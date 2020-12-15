//
//  ObjectExtensions.swift
//  Test
//
//  Created by a.belyaev3 on 28.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import CoreData


extension User {
    convenience init(user: ProfileModel,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.name = user.name
        self.profession = user.profession
        self.image = user.image?.pngData() ?? nil
    }
}

extension Conversation {
    convenience init(conversation: ConversationCellModel,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.identifier = conversation.identifier
        self.lastActivity = conversation.lastActivity?.dateValue()
        self.lastMessage = conversation.lastMessage
        self.name = conversation.name
    }
}

extension Message {
    convenience init(message: MessageCellModel,
                     in context: NSManagedObjectContext) {
        self.init(context: context)
        self.identifier = message.identifier
        self.content = message.content
        self.created = message.created
        self.senderId = message.senderId
        self.senderName = message.senderName
    }
}
