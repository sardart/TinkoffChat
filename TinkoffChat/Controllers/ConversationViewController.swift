//
//  ConversationViewController.swift
//  TinkoffChat
//
//  Created by Artur on 06/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextField: UITextField!
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
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        messageTextField.delegate = self
        
        if messages.isEmpty {
            let noMessagesLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
            noMessagesLabel.text = "Not messages yet"
            noMessagesLabel.textColor = UIColor.darkGray
            noMessagesLabel.font = UIFont.systemFont(ofSize: 14)
            noMessagesLabel.textAlignment = .center
            tableView.tableHeaderView = noMessagesLabel
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.scrollToBottom(animated: false)
    }

    @IBAction func sendTapped(_ sender: Any) {
        guard let text = messageTextField.text else { return }
        communicationManager.communicator.sendMessage(string: text, to: userName) { (true, error) in
            self.showAlert(title: "Error", message: error?.localizedDescription)
        }
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
        print("GOT MESSAGE \(text)")
        
        DispatchQueue.main.async {
            if self.messages.isEmpty {
                self.tableView.tableHeaderView = nil
            }
            
            self.messages.append(Message(messageText: text, date: Date(timeIntervalSinceNow: 0), type: .incoming))
            self.tableView.reloadData()
        }
    }
    
    
}
