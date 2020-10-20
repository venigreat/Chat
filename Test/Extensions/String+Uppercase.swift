//
//  String+Uppercase.swift
//  Test
//
//  Created by a.belyaev3 on 20.10.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
