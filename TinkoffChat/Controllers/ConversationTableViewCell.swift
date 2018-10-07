//
//  ConversationTableViewCell.swift
//  TinkoffChat
//
//  Created by Artur on 06/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ConversationTableViewCell: UITableViewCell, MessageCellConfiguration {
    
    @IBOutlet weak var messageTextLabel: UILabel!
    @IBOutlet weak var messageView: UIView!
    
    var messageText: String? {
        didSet {
            self.messageTextLabel.text = messageText
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageView.layer.borderWidth = 0.5
        messageView.layer.cornerRadius = 12
        messageView.layer.borderColor = UIColor.lightGray.cgColor
        messageView.layer.masksToBounds = true
        
        // Initialization code
    }
    
    func configure(with message: Message) {
        messageText = message.messageText
        
        switch message.type {
        case .incoming:
            messageView.backgroundColor = UIColor.white
        case .outgoing:
            messageView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        }
    }
    
}

