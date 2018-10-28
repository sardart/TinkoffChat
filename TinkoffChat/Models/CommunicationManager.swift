//
//  CommunicationManager.swift
//  TinkoffChat
//
//  Created by Artur on 28/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import Foundation
import MultipeerConnectivity


protocol CommunicationManagerUsersDelegate {
    var onlineConversations: [Conversation] {get set}
    var offlineConversations: [Conversation] {get set}
    
    func updateList()
}

protocol CommunicationManagerChatDelegate {
    var userName: String {get}
    
    func didRecieveMessage(message: Message)
    func userBecomeOffline()
    func userBecomeOnline()
}

protocol CommunicationManagerConnectionsDelegate {
    
}


class CommunicationManager {
    var usersDelegate: CommunicationManagerUsersDelegate?
    var chatDelegate: CommunicationManagerChatDelegate?
    
    var communicator = MultipeerCommunicator(online: true)
    
    init() {
        self.communicator.delegate = self
    }
    
    
}



extension CommunicationManager: CommunicatorDelagate {
    
    func didFoundUser(userID: String, userName: String) {
        if usersDelegate != nil {
            if !usersDelegate!.onlineConversations.isEmpty {
                for i in 0...usersDelegate!.onlineConversations.count - 1 {
                    let convarsation = usersDelegate!.onlineConversations[i]
                    if convarsation.name == userName {
                        return
                    }
                }
            }
            
            if !usersDelegate!.offlineConversations.isEmpty {
                for i in 0...usersDelegate!.offlineConversations.count - 1 {
                    let convarsation = usersDelegate!.offlineConversations[i]
                    if convarsation.name == userName {
                        usersDelegate!.offlineConversations.remove(at: i)
                        convarsation.online = true
                        usersDelegate?.onlineConversations.append(convarsation)
                        usersDelegate!.updateList()
                        return
                    }
                }
            }
            
            let lastMessage = MessagesStorage.getMessages(from: userName)?.last?.messageText
            let newConversations = Conversation(name: userName, message: lastMessage, date: nil, online: true, hasUnreadMessages: false)
            
            usersDelegate!.onlineConversations.append(newConversations)
            usersDelegate!.updateList()
        }
        
        if userID == chatDelegate?.userName {
            chatDelegate?.userBecomeOnline()
        }
    }
    
    func didLostUser(userID: String) {
        if usersDelegate != nil  &&  !usersDelegate!.onlineConversations.isEmpty {
            for i in 0...usersDelegate!.onlineConversations.count - 1 {
                let convarsation = usersDelegate!.onlineConversations[i]
                if convarsation.name == userID {
                    usersDelegate!.onlineConversations.remove(at: i)
                    convarsation.online = false
                    usersDelegate!.offlineConversations.append(convarsation)
                    usersDelegate!.updateList()
                    break
                }
            }
        }
        
        if userID == chatDelegate?.userName {
            chatDelegate?.userBecomeOffline()
        }
    }
    
    func failedToStartBrowsingForUsers(error: Error) {
        print(error.localizedDescription)
    }
    
    func failedToStartAdvertising(error: Error) {
        print(error.localizedDescription)
    }
    
    func didRecieveMessage(text: String, fromUser: String, toUser: String) {
        
        let incomingMessage = Message(messageText: text, date: Date.init(timeIntervalSinceNow: 0), type: .incoming)
        MessagesStorage.addMessage(from: fromUser, message: incomingMessage)
        
        usersDelegate?.updateList()
        
        
        if toUser == communicator.myPeerID.displayName && fromUser == chatDelegate?.userName {
            chatDelegate?.didRecieveMessage(message: incomingMessage)
        }
        
    }
    
}
