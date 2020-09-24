//
//  CustomButton.swift
//  Test
//
//  Created by a.belyaev3 on 24.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        //До вызова инита родительского класса доступа к frame нет
        Logger.log("Edit button frame: \(self.frame)")
    }
}
