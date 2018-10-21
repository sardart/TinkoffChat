//
//  OperationDataManager.swift
//  TinkoffChat
//
//  Created by Artur on 21/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


class OperationDataManager: DataManager {
    
    var delegate: DataManagerDelegate?
    
    func saveImage(_ image: UIImage, path: URL) {
        
        let myQueue = OperationQueue()
        let mainQueue = OperationQueue.main

        myQueue.qualityOfService = .userInitiated
        myQueue.maxConcurrentOperationCount = 1
        
        let savingOperation = SavingOperation(image: image, path: path)
        
        let finishedOperation = FinishingOperation(savingOperation: savingOperation, delegate: delegate, sender: self)
        
        finishedOperation.addDependency(savingOperation)

        savingOperation.completionBlock = {
            print("saving operation finished")
        }
        
        finishedOperation.completionBlock = {
            print("finishing operation done")
        }
    
        myQueue.addOperation(savingOperation)
        mainQueue.addOperation(finishedOperation)

    }
    
    
}


class SavingOperation: Operation {
    var image: UIImage
    var path: URL
    var success: Bool?
    
    init(image: UIImage, path: URL) {
        self.image = image
        self.path = path
    }
    
    override func main() {
        if let data = UIImagePNGRepresentation(image) {
            do {
                try data.write(to: path)
                success = true
            } catch {
                success = false
            }
        }
    }
    
    
}


class FinishingOperation: Operation {
    var delegate: DataManagerDelegate?
    var sender: DataManager
    var savingOperation: SavingOperation
    
    init(savingOperation: SavingOperation, delegate: DataManagerDelegate?, sender: DataManager) {
        self.sender = sender
        self.delegate = delegate
        self.savingOperation = savingOperation
    }
    
    override func main() {
        if savingOperation.success == true {
            self.delegate?.showAlert(title: "Success", message: "Data successfully saved (Operation)", success: true, sender: sender)
        } else {
            self.delegate?.showAlert(title: "Error", message: "Data saving failed (Operation)", success: true, sender: sender)
        }
    }
    
    
}
