//
//  UUIDGenerator.swift
//  Test
//
//  Created by a.belyaev3 on 01.11.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation

class UUIDGenerator {
    
    static var uuid: String {
        if let uuid = UserDefaults.standard.string(forKey: "uuid") {
            return uuid
        } else {
            let uuid = UUID().uuidString
            UserDefaults.standard.set(uuid, forKey: "uuid")
            return uuid
        }
    }
}
