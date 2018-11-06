//
//  CDUser.swift
//  TinkoffChat
//
//  Created by Artur on 05/11/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

//import Foundation
//import CoreData
//
//
//extension CDUser {
//    
//    static func findOrInsertAppUser(in context: NSManagedObjectContext) -> CDAppUser? {
//        guard let model = context.persistentStoreCoordinator?.managedObjectModel else {
//            print("Model is not available in context")
//            assert(false)
//            return nil
//        }
//        guard let fetchRequest = CDAppUser.fetchRequestAppUser(model) else { return nil }
//
//        var appUser: CDAppUser?
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            assert(results.count < 2, "Multiple AppUsers found")
//            if let foundUser = results.first {
//                appUser = foundUser
//            }
//        } catch {
//            print("Failed to fetch AppUser: \(error)")
//        }
//        
//        if appUser == nil {
//            appUser = CDAppUser.insertAppUser(in: context)
//        }
//        
//        return appUser
//    }
//    
//    
//}

