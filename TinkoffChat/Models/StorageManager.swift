//
//  StorageManager.swift
//  TinkoffChat
//
//  Created by Artur on 03/11/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import CoreData


class StorageManager {
    
    // MARK: - Properties
    
    static let shared = StorageManager()
    
    private let managedObjectModelName: String = "Storage"
    private let dataModelExtension: String = "momd"
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Core Data Stack
    
    private var storeURL: URL? {
        get {
            guard let documentsDirURL = FileManager.default.urls(for: .documentDirectory,
                                                                 in: .userDomainMask).first else  {
                print("Error documentsDirURL")
                return nil
            }
            let url = documentsDirURL.appendingPathComponent("Store.sqlite")
            
            return url
        }
    }
    
    private var _managedObjectModel: NSManagedObjectModel?
    private var managedObjectModel: NSManagedObjectModel? {
        get {
            if _managedObjectModel == nil {
                guard let modelURL = Bundle.main.url(forResource: self.managedObjectModelName,
                                                     withExtension: self.dataModelExtension) else {
                    print("Model url is empty")
                    return nil
                }
                _managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)
            }
            return _managedObjectModel
        }
    }

    private var _persistentStoreCoordinator: NSPersistentStoreCoordinator?
    private var persistentStoreCoordinator: NSPersistentStoreCoordinator? {
        get {
            if _persistentStoreCoordinator == nil {
                guard let model = self.managedObjectModel else {
                    print("Managed object model is empty")
                    return nil
                }
                
                _persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
                
                do {
                    try _persistentStoreCoordinator?.addPersistentStore(ofType: NSSQLiteStoreType,
                                                                        configurationName: nil,
                                                                        at: self.storeURL,
                                                                        options: nil)
                } catch {
                    assert(false, "Error adding persistent store to coordinator: \(error)")
                }
            }
        
            return _persistentStoreCoordinator
        }
    }
    
    private var _masterContext: NSManagedObjectContext?
    private var masterContext: NSManagedObjectContext? {
        get {
            if _masterContext == nil {
                guard let persistentStoreCoordinator = self.persistentStoreCoordinator else {
                    print("Empty persistent store coordinator")
                    return nil
                }
                
                let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                context.persistentStoreCoordinator = persistentStoreCoordinator
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _masterContext = context
            }
            
            return _masterContext
        }
    }
    
    private var _mainContext: NSManagedObjectContext?
    private var mainContext: NSManagedObjectContext? {
        get {
            if _mainContext == nil {
                guard let parentContext = self.masterContext else {
                    print("No master context!")
                    return nil
                }
                
                let context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _mainContext = context
            }
            
            return _mainContext
        }
    }
    
    private var _saveContext: NSManagedObjectContext?
    private var saveContext: NSManagedObjectContext? {
        get {
            if _saveContext == nil {
                guard let parentContext = self.mainContext else {
                    print("No master context!")
                    return nil
                }
                
                let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
                context.parent = parentContext
                context.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
                context.undoManager = nil
                _saveContext = context
            }
            
            return _saveContext
        }
    }
    
    public func perfomSave(context: NSManagedObjectContext, completionHandler: (() -> Void)?) {
        if context.hasChanges {
            context.perform { [weak self] in
                do {
                    try context.save()
                } catch {
                    print("Context save error: \(error)")
                }
                
                if let parent = context.parent {
                    self?.perfomSave(context: parent, completionHandler: completionHandler)
                } else {
                    completionHandler?()
                }
            }
        } else {
            completionHandler?()
        }
    }
    
}

