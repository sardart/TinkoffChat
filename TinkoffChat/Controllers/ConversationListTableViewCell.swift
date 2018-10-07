//
//  ConversationListTableViewCell.swift
//  TinkoffChat
//
//  Created by Artur on 07/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//


import UIKit


class ConversationListTableViewCell: UITableViewCell, ConversationCellConfiguration {
    
    var name: String? {
        didSet {
            fullNameLabel.text = name
        }
    }
    
    var message: String? {
        didSet {
            if message != nil && !hasUnreadMessages {
                messageLabel.font = UIFont.systemFont(ofSize: 14)
                messageLabel.textColor = UIColor.lightGray
                messageLabel.text = message
            } else if message != nil && hasUnreadMessages {
                messageLabel.font = UIFont.boldSystemFont(ofSize: 14)
                messageLabel.textColor = UIColor.lightGray
                messageLabel.text = message
            } else {
                messageLabel.font = UIFont(name: "Arial", size: 14)
                messageLabel.textColor = UIColor.darkGray
                messageLabel.text = "No messages yet"
            }
        }
    }
    
    var date: Date? {
        didSet {
            datetimeLabel.text = Date.getDatetimeString(from: date)
        }
    }
    
    var online: Bool = true {
        didSet {
            if online {
                backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 0.3020654966)
            } else {
                backgroundColor = UIColor.white
            }
        }
    }
    var hasUnreadMessages: Bool = true
    
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var datetimeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.masksToBounds = true
        
    }
    
    func configure(with conversation: Conversation) {
        name = conversation.name
        message = conversation.message
        date = conversation.date
        hasUnreadMessages = conversation.hasUnreadMessages
        online = conversation.online
    }
    
}
