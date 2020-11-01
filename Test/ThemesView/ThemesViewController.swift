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
    
    @IBOutlet weak var classicButton: UIButton!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var nightButton: UIButton!
    var classicButtonView: ThemesButtonView?
    var dayButtonView: ThemesButtonView?
    var nightButtonView: ThemesButtonView?
    weak var delegate: ChangeThemeDelegate?
    // без weak - две сильные ссылки на объекты
    var themeManager = ThemeManager()
    var previousTheme: Theme = .classic
    var callback: (() -> Void)?
    
    override func viewDidLoad() {
        previousTheme = themeManager.getTheme()
        configureThemeButtons()
        super.viewDidLoad()
    }
    
    @IBAction func tapCancelButton(_ sender: Any) {
        themeManager.saveTheme(vc: self, previousTheme) {
            self.delegate?.changeTheme(sender: sender)
            self.refreshButtons()
            self.navigationController?.popViewController(animated: true)
        }
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
        themeManager.saveTheme(vc: self, theme) {
            self.refreshButtons()
    //        self.callback?()
            self.delegate?.changeTheme(sender: sender)
        }
    }
    
    private func configureThemeButtons() {
        classicButtonView = ThemesButtonView(x: classicButton.frame.minX, y: classicButton.frame.minY, theme: .classic)
        dayButtonView = ThemesButtonView(x: dayButton.frame.minX, y: dayButton.frame.minY, theme: .day)
        nightButtonView = ThemesButtonView(x: nightButton.frame.minX, y: nightButton.frame.minY, theme: .night)
        let viewArray = [classicButtonView, dayButtonView, nightButtonView]
        for buttonView in viewArray {
            if let buttonView = buttonView {
                buttonView.isUserInteractionEnabled = false
                view.addSubview(buttonView)
            }
        }
    }
    
    private func refreshButtons() {
        let viewArray = [classicButtonView, dayButtonView, nightButtonView]
        for view in viewArray {
            if let view = view {
                view.setBorder()
            }
        }
    }
}
