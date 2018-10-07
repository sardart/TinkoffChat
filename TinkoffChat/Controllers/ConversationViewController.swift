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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let conversationsManager = ConversationsManager()
        messages = conversationsManager.getMessages(count: 40)

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
