//
//  Message.swift
//  TinkoffChat
//
//  Created by Artur on 07/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation

protocol MessageCellConfiguration: class {
    var messageText: String? {get set}
}

enum MessageType {
    case incoming
    case outgoing
}

class Message: MessageCellConfiguration {
    var messageText: String?
    var type: MessageType
    
    init(messageText: String?, type: MessageType) {
        self.messageText = messageText
        self.type = type
    }
    
    
}
