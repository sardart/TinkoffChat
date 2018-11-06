//
//  CDAppUser.swift
//  TinkoffChat
//
//  Created by Artur on 05/11/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

//import Foundation
//import CoreData
//
//extension CDAppUser {
//    static func fetchRequestAppUser(_ model: NSManagedObjectModel) -> NSFetchRequest<CDAppUser>? {
//        let templateName = "CDAppUser"
//        guard let fetchRequest = model.fetchRequestTemplate(forName: templateName) as? NSFetchRequest<CDAppUser> else {
//            assert(false, "No template with name \(templateName)")
//            return nil
//        }
//        
//        return fetchRequest
//    }
//
//    static func insertAppUser(in context: NSManagedObjectContext) -> CDAppUser? {
//        guard let appUser = NSEntityDescription.insertNewObject(forEntityName: "CDAppUser", into: context) as? CDAppUser else { return nil }
//
//        if appUser.currentUser == nil {
//            let currentUser = CDUser.findOrInsertAppUser(in: <#T##NSManagedObjectContext#>)
//        }
//
//        return appUser
//    }
//
//}
