//
//  CoreDataContainer.swift
//  Test
//
//  Created by a.belyaev3 on 05.12.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import CoreData

class CoreDataContainer {
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Users")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError(error.localizedDescription)
            }
            
        }
    }
}
