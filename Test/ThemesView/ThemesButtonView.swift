//
//  ThemesButtonView.swift
//  Test
//
//  Created by a.belyaev3 on 18.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ThemesButtonView: UIStackView {
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var otherMessageView: UIView!
    @IBOutlet weak var myMessageView: UIView!
    var buttonTheme: Theme = .classic
    
    init(x: CGFloat, y: CGFloat, theme: Theme) {
        buttonTheme = theme
        super.init(frame: CGRect(x: x, y: y, width: 200, height: 93.5))
        distribution = .fill
        alignment = .fill
        if let nibView = Bundle.main.loadNibNamed("ThemeButtonView",
                                                  owner: self,
                                                  options: nil)?.first as? ThemesButtonView {
            addArrangedSubview(nibView)
            instanceFromNib(theme: theme)
        }
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func instanceFromNib(theme: Theme) {
        buttonView.backgroundColor = theme.backgroundColor
        nameLabel.text = theme.rawValue.capitalizingFirstLetter()
        otherMessageView.backgroundColor = theme.otherMessageColor
        myMessageView.backgroundColor = theme.myMessageColor
        setBorder()
    }
    
    func setBorder() {
        if ThemeManager().getTheme() == buttonTheme {
            buttonView.layer.borderWidth = 3
            buttonView.layer.borderColor = UIColor.yellow.cgColor
        } else {
            buttonView.layer.borderWidth = 0
        }
    }
}
