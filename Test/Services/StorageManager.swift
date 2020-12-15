//
//  StorageManager.swift
//  Test
//
//  Created by a.belyaev3 on 28.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import CoreData

class StorageManager {
    
    var persistentCoordinator: NSPersistentStoreCoordinator = {
            
        let modelURL = Bundle.main.url(forResource: "Test", withExtension: "momd")
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL!)
        let persistentCoordinator = NSPersistentStoreCoordinator(managedObjectModel:
                                                managedObjectModel!)
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)[0]
        let storeURL = URL(fileURLWithPath: documentsPath.appending("/Test.sqlite"))
        print("storeUrl = \(storeURL)")
        do {
            try persistentCoordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                                 configurationName: nil,
                                                 at: storeURL,
                                                 options: [NSSQLitePragmasOption:
                                                              ["journal_mode":"MEMORY"]])
            return persistentCoordinator
        } catch {
            abort()
        }
    } ()
}
