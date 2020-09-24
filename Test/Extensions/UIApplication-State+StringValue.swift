//
//  UIApplication-State+StringValue.swift
//  Test
//
//  Created by a.belyaev3 on 24.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

extension UIApplication.State {
    var stringValue: String {
        switch self {
        case .active: return "active"
        case .background: return "background"
        case .inactive: return "inactive"
        default: return "unknown"
        }
    }
}
