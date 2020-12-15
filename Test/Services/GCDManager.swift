//
//  GCDManager.swift
//  Test
//
//  Created by a.belyaev3 on 24.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class GCDManager: ISaveData {
    let queue = DispatchQueue.global(qos: .utility)
    let manager = ResoucesManager()
    
    func saveUser(vc: UIViewController, model: ProfileModel, closure: @escaping () -> Void) {
        queue.async {
//            if let name = model.name {
//                self.manager.write(vc: vc, value: name, fileName: .title)
//            }
//
//            if let profession = model.profession {
//                self.manager.write(vc: vc, value: profession, fileName: .profession)
//            }
//
//            if let image = model.image {
//                self.manager.write(vc: vc, value: image, fileName: .avatar)
//            }
            CoreDataManager.saveUser(user: model)
            DispatchQueue.main.async {
                closure()
            }
        }
    }
    
    func saveTheme(vc: UIViewController, theme: Theme, closure: @escaping () -> Void) {
        queue.async {
            self.manager.write(vc: vc, value: theme.rawValue, fileName: .theme)
            DispatchQueue.main.async {
                closure()
            }
        }
    }
}
