//
//  Conversation.swift
//  TinkoffChat
//
//  Created by Artur on 07/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation


protocol ConversationCellConfiguration: class {
    var name: String {get set}
    var message: String? {get set}
    var date: Date? {get set}
    var online: Bool {get set}
    var hasUnreadMessages: Bool {get set}
}

class Conversation: ConversationCellConfiguration {
    var name: String
    var message: String?
    var date: Date?
    var online: Bool
    var hasUnreadMessages: Bool
    
    init(name: String, message: String?, date: Date?, online: Bool, hasUnreadMessages: Bool) {
        self.name = name
        self.message = message
        self.date = date
        self.online = online
        self.hasUnreadMessages = hasUnreadMessages
    }
}
