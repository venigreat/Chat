//
//  CoreDataStack.swift
//  Test
//
//  Created by a.belyaev3 on 28.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataStack {
    
    var didUpdateDataBase: ((CoreDataStack) -> Void)?
    
    private var storeUrl: URL = {
        guard let documentsUrl = FileManager.default.urls(for: .documentDirectory,
                                                          in: .userDomainMask).last
        else {
            fatalError("Documents path not found")
        }
        return documentsUrl.appendingPathComponent("Users.sqlite")
    }()
    
    private let dataModelName = "Users"
    private let dataModelExtension = "momd"
    
    // MARK: - init stack
    
    private(set) lazy var madagedObjectModel: NSManagedObjectModel = {
        guard let modelUrl = Bundle.main.url(forResource: dataModelName,
                                             withExtension: dataModelExtension)
        else {
            fatalError("Model not found")
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)
        else {
            fatalError("managedObjectModel not found")
        }
        return managedObjectModel
    }()
    
    private lazy var persistantStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: madagedObjectModel)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: storeUrl,
                                               options: nil)
        } catch {
            fatalError(error.localizedDescription)
        }
        return coordinator
    }()
    
    // MARK: - Contexts
    
    private lazy var writterContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = persistantStoreCoordinator
        context.mergePolicy = NSOverwriteMergePolicy
        return context
    }()
    
    private lazy var mainContext: NSManagedObjectContext = {
        let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = writterContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return context
    }()
    
    private func saveContext() -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = mainContext
        context.automaticallyMergesChangesFromParent = true
        context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return context
    }
    
    func save(_ block: (NSManagedObjectContext) -> Void) {
        let context = saveContext()
        
        context.performAndWait {
            block(context)
            
            if context.hasChanges {
                do {
                    try performSave(in: context)
                } catch {
                    fatalError(error.localizedDescription)
                }
            }
        }
    }
    
    func fetchUser() -> ProfileModel {
        
    }
    
    private func performSave(in context: NSManagedObjectContext) throws {
        try context.save()
        
        if let parent = context.parent {
            try performSave(in: parent)
        }
    }
}
