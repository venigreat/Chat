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
    static func getTheme() -> Theme {
        let themeName = UserDefaults.standard.string(forKey: "Theme")
        return Theme.getTheme(themeName)
    }
    
    static func saveTheme(_ theme: Theme){
        UserDefaults.standard.set(theme.rawValue, forKey: "Theme")
    }
}
