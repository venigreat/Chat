//
//  ISaveData.swift
//  Test
//
//  Created by a.belyaev3 on 26.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import UIKit

protocol ISaveData {
    func saveUser(vc: UIViewController, model: ProfileModel, closure: @escaping () -> Void)
}
