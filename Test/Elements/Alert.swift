//
//  Alert.swift
//  Test
//
//  Created by a.belyaev3 on 24.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class Alert {
    
    let alert: UIAlertController
    
    init(title: String?, message: String?) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    }
    
    func addRepeatButton(closure: @escaping (UIAlertAction) -> Void) {
        alert.addAction(UIAlertAction(title: "Повторить", style: .default, handler: closure))
    }
}
