//
//  OperationManager.swift
//  Test
//
//  Created by a.belyaev3 on 26.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import UIKit

class OperationManager: Operation, ISaveData {
    
    let view: UIViewController
    let profileModel: ProfileModel
    let fileManager = ResoucesManager()
    let queue = OperationQueue()
    
    init(vc: UIViewController, model: ProfileModel) {
        view = vc
        profileModel = model
    }
    
    override func main() {
        if let name = profileModel.name {
            self.fileManager.write(vc: view, value: name, fileName: .title)
        }
        
        if let profession = profileModel.profession {
            self.fileManager.write(vc: view, value: profession, fileName: .profession)
        }
        
        if let image = profileModel.image {
            self.fileManager.write(vc: view, value: image, fileName: .avatar)
        }
    }
    
    func saveUser(vc: UIViewController, model: ProfileModel, closure: @escaping () -> Void) {
        let operation = OperationManager(vc: vc, model: model)
        queue.addOperation(operation)
        OperationQueue.main.addOperation {
            closure()
        }
    }
}
