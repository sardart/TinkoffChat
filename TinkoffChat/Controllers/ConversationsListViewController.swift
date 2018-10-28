//
//  ConversationsListViewController.swift
//  TinkoffChat
//
//  Created by Artur on 06/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController, ThemesViewControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView()
        }
    }
    
    var onlineConversations = [Conversation]()
    var offlineConversations = [Conversation]()
    let conversationsManager = ConversationsManager()
    var communicationManager = CommunicationManager()
    
    
    lazy var changeThemeWithClosure: (UIColor) -> () = { [weak self] (theme: UIColor) in
        self?.logThemeChanging(selectedTheme: theme)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        communicationManager.usersDelegate = self
        
        
        //        onlineConversations = conversationsManager.getConversations(count: 20, online: true)
        //        offlineConversations = conversationsManager.getConversations(count: 20, online: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateList()
    }
    
    func themesViewController(_ controller: ThemesViewController, didSelectTheme selectedTheme: UIColor) {
        logThemeChanging(selectedTheme: selectedTheme)
    }
    
    func logThemeChanging(selectedTheme: UIColor) {
        print(selectedTheme)
        setTheme(selectedTheme)
        saveTheme(selectedTheme)
    }
    
    func setTheme(_ theme: UIColor) {
        UINavigationBar.appearance().backgroundColor = theme
    }
    
    func saveTheme(_ theme: UIColor) {
        UserDefaults.standard.set(theme, forKey: "theme")
    }
    
    
    @IBAction func themesTapped(_ sender: Any) {
        let themesVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ThemesViewController") as! ThemesViewController
        themesVC.delegate = self
        themesVC.title = "Themes"
        
        let navController = UINavigationController(rootViewController: themesVC)
        self.present(navController, animated: true, completion: nil)
    }
    
    @IBAction func profileTapped(_ sender: Any) {
        let profileVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        let navController = UINavigationController(rootViewController: profileVC)
        self.present(navController, animated: true, completion: nil)
    }
    
}


extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversationListCell", for: indexPath) as! ConversationListTableViewCell
        switch indexPath.section {
        case 0:
            cell.configure(with: onlineConversations[indexPath.row])
        case 1:
            cell.configure(with: offlineConversations[indexPath.row])
        default:
            break
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return onlineConversations.count
        case 1:
            return offlineConversations.count
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Online"
        case 1:
            return "History"
        default:
            return ""
        }
    }
    
    
}


extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCell = tableView.cellForRow(at: indexPath) as! ConversationListTableViewCell
        
        
        let conversationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ConversationViewController") as! ConversationViewController
        
        switch indexPath.section {
        case 0:
            conversationVC.isOnline = true
            onlineConversations[indexPath.row].hasUnreadMessages = false
        case 1:
            conversationVC.isOnline = false
            offlineConversations[indexPath.row].hasUnreadMessages = false
        default:
            break
        }
        
        conversationVC.userName = selectedCell.name
        conversationVC.communicationManager = communicationManager
        communicationManager.chatDelegate = conversationVC
        
        navigationController?.pushViewController(conversationVC, animated: true)
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}


extension ConversationsListViewController: CommunicationManagerUsersDelegate {
    
    func dateAndName(_ left: Conversation, _ right: Conversation) -> Bool {
        guard let leftDate = left.date,
            let rightDate = right.date else {
                return left.name < right.name
                
        }
        return leftDate < rightDate
    }
    
    func updateConversations(_ conversations: [Conversation]) {
        for conversation in conversations {
            guard let lastMessage = MessagesStorage.getMessages(from: conversation.name)?.last else {
                conversation.hasUnreadMessages = false
                continue
            }
            conversation.message = lastMessage.messageText
            conversation.date = lastMessage.date
        }
    }
    
    func updateList() {
        updateConversations(self.onlineConversations)
        updateConversations(self.offlineConversations)
        
        self.onlineConversations = self.onlineConversations.sorted(by: dateAndName)
        self.offlineConversations = self.offlineConversations.sorted(by: dateAndName)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}









