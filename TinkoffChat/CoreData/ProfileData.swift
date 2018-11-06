//
//  ProfileData.swift
//  TinkoffChat
//
//  Created by Artur on 05/11/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import CoreData


extension ProfileData {
    
    // MARK: - Properties

    static let entityName = "ProfileData"
    
    // MARK: - Core Data
    
    static func fetchRequestProfileData() -> NSFetchRequest<ProfileData> {
        let fetchRequest = NSFetchRequest<ProfileData>(entityName: ProfileData.entityName)
        
        return fetchRequest
    }
    
    static func insertProfileData(in context: NSManagedObjectContext) -> ProfileData? {
        guard let profileData = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as? ProfileData else { return nil }
        
        profileData.name = "test name"
        profileData.aboutMe = "test about me"
        
        return profileData
    }
    
    static func findOrInsertProfileData(in context: NSManagedObjectContext) -> ProfileData? {
        let fetchRequest = ProfileData.fetchRequestProfileData()
        var profileData: ProfileData?
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2, "Multiple ProfileData found")
            if let foundData = results.first {
                profileData = foundData
            }
        } catch {
            print("Failed to fetch ProfileData: \(error)")
        }
        
        if profileData == nil {
            profileData = ProfileData.insertProfileData(in: context)
        }
        
        return profileData
    }
    
    
}
