//
//  ThemesViewControllerSwift.swift
//  TinkoffChat
//
//  Created by Artur on 14/10/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ThemesViewControllerSwift: UIViewController {
    
    @IBOutlet var buttons: [UIButton]!

    let model = Theme()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UINavigationBar.appearance().backgroundColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        animatedButtonsAppearance()
    }
    
    @IBAction func themeTapped(_ sender: UIButton) {
        var theme = model.defaultTheme
        
        switch (sender.tag) {
        case 1:
            theme = self.model.redTheme;
            break;
        case 2:
            theme = self.model.blueTheme;
            break;
        case 3:
            theme = self.model.darkTheme;
            break;
        default:
            break;
        }
        changeTheme(theme)
    }
    
    func changeTheme(_ theme: UIColor) {
        self.view.backgroundColor = theme
        self.navigationController?.navigationBar.backgroundColor = theme
        let vc = ConversationsListViewController()
        vc.changeThemeWithClosure(theme)
    }
    
    func animatedButtonsAppearance() {
        for button in self.buttons {
            button.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }
        
        UIView.animate(withDuration: 1) {
            for button in self.buttons {
                button.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
