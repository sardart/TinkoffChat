//
//  DataManager.swift
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

extension DataManager {
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
    func saveText(_ text: String, key: String) {
        let userDefault = UserDefaults.standard
        userDefault.set(text, forKey: key)
    }
    
}
