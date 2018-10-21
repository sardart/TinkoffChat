//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by Artur on 21/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import UIKit

protocol DataManagerDelegate {
    func showAlert(title: String, message: String, success: Bool, sender: DataManager)
}

protocol DataManager {
    func saveImage(_ image: UIImage, path: URL)
    func saveText(_ text: String, key: String)
    func loadText(key: String) -> String?
    func loadImage(path: URL) -> UIImage?
}

class GCDDataManager: DataManager {
    func loadText(key: String) -> String? {
        let userDefault = UserDefaults.standard
        let text = userDefault.value(forKey: key) as? String
        return text
    }
    
    func loadImage(path: URL) -> UIImage? {
        guard FileManager.default.fileExists(atPath: path.path),
            let image = UIImage(contentsOfFile: path.path) else {
                return nil
        }
        return image
    }
    
    var delegate: DataManagerDelegate?

    func saveImage(_ image: UIImage, path: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = UIImagePNGRepresentation(image) {
                do {
                    try data.write(to: path)
                    DispatchQueue.main.async {
                        self.delegate?.showAlert(title: "Success", message: "Data successfully saved", success: true, sender: self)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.showAlert(title: "Error", message: "Data saving failed", success: false, sender: self)
                    }
                }
            }
        }
    }
    
    func saveText(_ text: String, key: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(text, forKey: key)
    }
    
    
}
