//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Artur on 06/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    var navBarTitle: String? {
        didSet {
            navigationController?.title = navBarTitle
        }
    }
    
    var messages = [Message]()
    var communicationManager: CommunicationManager!
    
    var userName: String = "" {
        didSet {
            self.title = userName
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if messages.isEmpty {
            let noMessagesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
            noMessagesLabel.text = "Not messages yet"
            noMessagesLabel.textColor = UIColor.darkGray
            noMessagesLabel.font = UIFont.systemFont(ofSize: 14)
            noMessagesLabel.textAlignment = .center
            tableView.tableHeaderView = noMessagesLabel
        }
        
        communicationManager.communicator.sendMessage(string: "HELLO WORLD BITCH", to: userName) { (true, error) in
        
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.scrollToBottom(animated: false)
    }


}


extension ConversationViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        var cell = ConversationTableViewCell()
        
        switch message.type {
        case .incoming:
            cell = tableView.dequeueReusableCell(withIdentifier: "incomingСonversationCell", for: indexPath) as! ConversationTableViewCell
        case .outgoing:
            cell = tableView.dequeueReusableCell(withIdentifier: "outgoingСonversationCell", for: indexPath) as! ConversationTableViewCell
        }
        
        cell.configure(with: message)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
}

extension ConversationViewController: UITableViewDelegate {
    
}

extension ConversationViewController: CommunicationManagerChatDelegate {
    
    func didRecieveMessage(text: String) {
        if messages.isEmpty {
            self.tableView.tableHeaderView = nil
        }
        
        messages.append(Message(messageText: text, type: .incoming))
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: .automatic)
        self.tableView.endUpdates()
    }
    
    
}
