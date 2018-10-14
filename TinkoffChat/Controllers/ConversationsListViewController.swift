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
    
    lazy var changeThemeWithClosure: (UIColor) -> () = { [weak self] (theme: UIColor) in
        self?.logThemeChanging(selectedTheme: theme)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onlineConversations = conversationsManager.getConversations(count: 20, online: true)
        offlineConversations = conversationsManager.getConversations(count: 20, online: false)
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
        conversationVC.title = selectedCell.name
        if let lastMessage = selectedCell.message {
            conversationVC.messages = conversationsManager.getMessages(count: 50)
            conversationVC.messages.append(Message(messageText: lastMessage, type: .incoming))
        }
        navigationController?.pushViewController(conversationVC, animated: true)
        
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    
}









