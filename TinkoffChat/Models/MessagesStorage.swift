//
//  MessagesStorage.swift
//  TinkoffChat
//
//  Created by Artur on 28/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


class MessagesStorage {
    
    static private var messages = [String: [Message]]()
    
    static func getMessages(from userName: String) -> [Message]? {
        let messagesDict = MessagesStorage.messages as NSDictionary
        let messages = messagesDict.value(forKey: userName) as? [Message]
        
        return messages
    }
    
    static func saveMessages(from userName: String, messages: [Message]) {
        MessagesStorage.messages[userName] = messages
    }
    
    
}
