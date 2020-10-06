//
//  ConversationViewController.swift
//  Test
//
//  Created by a.belyaev3 on 30.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        cell.configure(with: messagesList[indexPath.row])

        return cell
    }
    
    var name: String = "Nobody"
    let messagesList = DataManager().getChatMessages()
    
    private let cellIdentifier = String(describing: MessageCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorColor = .clear
        tableView.backgroundColor = .gray
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        navigationItem.title = name
    }
}
