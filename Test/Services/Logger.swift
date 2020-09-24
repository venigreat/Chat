//
//  Logger.swift
//  Test
//
//  Created by a.belyaev3 on 18.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation
import UIKit

class Logger {
    
    //MARK: - Public
    
    static func log(_ message: String) {
        self.log(string: message)
    }
    static func changeState(from firstState: String, to secondState: String, method: String) {
        self.log(string: "Application moved from \(firstState) to \(secondState): \(method)")
    }
    
    //MARK: - Private
    
    private static func log(string: String) {
        #if DEBUG
        print(string)
        #endif
    }
}
