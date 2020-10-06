//
//  ConfigurableView.swift
//  Test
//
//  Created by a.belyaev3 on 30.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import Foundation

protocol ConfigurableView {
    
    associatedtype ConfigurationModel
    
    func configure(with model: ConfigurationModel)
}
