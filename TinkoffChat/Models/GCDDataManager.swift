//
//  GCDDataManager.swift
//  TinkoffChat
//
//  Created by Artur on 21/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import UIKit

class GCDDataManager: DataManager {
    
    var delegate: DataManagerDelegate?

    func saveImage(_ image: UIImage, path: URL) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let data = UIImagePNGRepresentation(image) {
                do {
                    try data.write(to: path)
                    DispatchQueue.main.async {
                        self.delegate?.showAlert(title: "Success", message: "Data successfully saved (GCD)", success: true, sender: self)
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.delegate?.showAlert(title: "Error", message: "Data saving failed (GCD)", success: false, sender: self)
                    }
                }
            }
        }
    }
    

}
