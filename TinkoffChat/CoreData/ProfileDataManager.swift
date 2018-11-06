//
//  ProfileDataManager.swift
//  TinkoffChat
//
//  Created by Artur on 06/11/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


protocol ProfileDataManagerDelegate {
    func showAlert(title: String, message: String?)
    func didEndSaving()
    func willStartSaving()

}

class ProfileDataManager {
    
    // MARK: - Properties
    
    var delegate: ProfileDataManagerDelegate?
    
    // MARK: - Data Saving
    
    func save(name: String?, aboutMe: String?, photo: UIImage?) {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let saveContext = StorageManager.shared.getContext(.save) else {
                self.delegate?.showAlert(title: "Error", message: "Get context error")
                return
            }
            
            guard let profileData = ProfileData.findOrInsertProfileData(in: saveContext) else {
                self.delegate?.showAlert(title: "Error", message: "Failed to save profile data")
                return
            }
            
            DispatchQueue.main.async {
                self.delegate?.willStartSaving()
            }
            
            profileData.name = name
            profileData.aboutMe = aboutMe
            if let avatarImage = photo,
                let avatarData = UIImagePNGRepresentation(avatarImage) {
                profileData.avatar = avatarData

            }
            
            if saveContext.hasChanges {
                StorageManager.shared.perfomSave(context: saveContext) {
                    self.delegate?.showAlert(title: "Success", message: "Profile data successfully saved with CoreData")
                }
            } else {
                self.delegate?.showAlert(title: "Warning", message: "Nothing to save")
            }
            
            DispatchQueue.main.async {
                self.delegate?.didEndSaving()
            }
        }
    }
    
    func load() -> ProfileData? {
        guard let mainContext = StorageManager.shared.getContext(.main) else {
            self.delegate?.showAlert(title: "Error", message: "Get context error")
            return nil
        }
        
        let profileData = ProfileData.findOrInsertProfileData(in: mainContext)
        
        return profileData
    }
    

}
