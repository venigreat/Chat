//
//  ThemesViewController.swift
//  Test
//
//  Created by a.belyaev3 on 07.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

protocol ChangeThemeDelegate: class {
    func changeTheme(sender: Any)
}

class ThemesViewController: UIViewController {
    
    weak var delegate: ChangeThemeDelegate?
    // без weak - две сильные ссылки на объекты
    var previousTheme: Theme = .classic
    var callback: (() -> ())?
    
    override func viewDidLoad() {
        previousTheme = ThemeManager.getTheme()
        super.viewDidLoad()
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        ThemeManager.saveTheme(previousTheme)
        delegate?.changeTheme(sender: sender)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapClassicButton(_ sender: Any) {
        changeTheme(.classic, sender)
    }
    @IBAction func tapDayButton(_ sender: Any) {
        changeTheme(.day, sender)
    }
    
    @IBAction func tapNightButton(_ sender: Any) {
        changeTheme(.night, sender)
    }
    
    private func changeTheme(_ theme: Theme, _ sender: Any) {
        ThemeManager.saveTheme(theme)
//        callback?()
        delegate?.changeTheme(sender: sender)
    }
}
