//
//  ViewController.swift
//  Test
//
//  Created by a.belyaev3 on 18.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        Logger.log(#function)
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Logger.log(#function)
        super.viewDidAppear(animated)
    }
    
    override func viewWillLayoutSubviews() {
        Logger.log(#function)
        super.viewWillLayoutSubviews()
    }
    
    override func viewDidLayoutSubviews() {
        Logger.log(#function)
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Logger.log(#function)
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Logger.log(#function)
        super.viewDidAppear(animated)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Chat"
        navigationItem.backBarButtonItem = backItem 
    }
}

