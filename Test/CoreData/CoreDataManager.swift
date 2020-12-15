//
//  CoreDataManager.swift
//  Test
//
//  Created by a.belyaev3 on 28.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager {
    
//    private static let coreDataStack = CoreDataStack()
    static let context = CoreDataContainer().persistentContainer.viewContext
    
    static func saveUser(user: ProfileModel) {
        _ = User(user: user, in: context)
        saveContext()
    }
    
    static func fetchUser() -> ProfileModel {
        var user = ProfileModel(name: "Name", profession: "Profession", image: nil)
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: User.self))
        do {
            if let result = try context.fetch(request) as? [User] {
                guard let userFromDB = result.last else { return user }
                user.name = userFromDB.name ?? user.name
                user.profession = userFromDB.profession ?? user.profession
                if let image = userFromDB.image {
                     user.image = UIImage(data: image)
                } else {
                    user.image = nil
                }
            }
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
        return user
    }
    
    static func fetchConversations() -> NSFetchedResultsController<Conversation> {
        let fetchRequest: NSFetchRequest<Conversation> = Conversation.fetchRequest()
        let sort = NSSortDescriptor(key: "lastActivity", ascending: false)
        
        fetchRequest.sortDescriptors = [sort]
        fetchRequest.fetchBatchSize = 20
        
        let fetchedResultController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                 managedObjectContext: context,
                                                                 sectionNameKeyPath: nil,
                                                                 cacheName: nil)
        fetchedResultController.delegate = self
    }
    
    static func saveContext() {
        do {
            try context.save()
            Logger.log("Context is saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    static func saveConversations(conversations: [ConversationCellModel]) {
        _ = conversations.map { Conversation(conversation: $0, in: context) }
        saveContext()
    }
}
