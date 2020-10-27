//
//  ThemesManager.swift
//  Test
//
//  Created by a.belyaev3 on 12.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

enum Theme: String {
    case classic
    case day
    case night
    
    static func getTheme(_ name: String?) -> Theme {
        switch name {
        case "day":
            return .day
        case "night":
            return .night
        default:
            return .classic
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .classic, .day:
            return .white
        case .night:
            return .black
        }
    }
    
    var myMessageColor: UIColor {
        switch self {
        case .classic:
            return .green
        case .day:
            return .blue
        case .night:
            return .gray
        }
    }
    
    var otherMessageColor: UIColor {
        switch self {
        case .classic, .day:
            return .gray
        case .night:
            return .yellow
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .classic, .day:
            return .black
        case .night:
            return .white
        }
    }
}

class ThemeManager {
    
    private var current: Theme?
    
    func getTheme() -> Theme {
        if let theme = current {
            return theme
        } else {
            let themeName = ResoucesManager().read(fileName: .theme)// UserDefaults.standard.string(forKey: "Theme")
            let userDefaultTheme = Theme.getTheme(themeName)
            current = userDefaultTheme
            return userDefaultTheme
        }
    }
    
    func saveTheme(vc: UIViewController, _ theme: Theme, closure: @escaping () -> Void) {
        GCDManager().saveTheme(vc: vc, theme: theme, closure: closure)
    }
}
