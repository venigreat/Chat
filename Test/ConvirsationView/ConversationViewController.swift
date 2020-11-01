//
//  ConversationViewController.swift
//  Test
//
//  Created by a.belyaev3 on 30.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ConversationViewController: UIViewController, UITableViewDataSource {
    
    lazy var textField = UITextField(frame: CGRect(x: 0, y: 0, width: view.frame.width * 0.7, height: 70))
    var name: String = "Nobody"
    var screenId: String = ""
    var messagesList: [MessageCellModel] = []
    
    private let cellIdentifier = String(describing: MessageCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.cellLayoutMarginsFollowReadableWidth = true
        tableView.separatorColor = .clear
        tableView.backgroundColor = .gray
        tableView.tableFooterView = footerView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        setupTheme()

        FirebaseManager.readMessages(screenId: screenId) { messages in
            self.messagesList = messages
            self.refreshTableView()
        }
        navigationItem.title = name
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messagesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? MessageCell else {
            return UITableViewCell()
        }
        cell.configure(with: messagesList[indexPath.row])

        return cell
    }
    
    func refreshTableView() {
        tableView.reloadData()
    }
    
    private func setupTheme() {
        let theme = ThemeManager().getTheme()
        tableView.backgroundColor = theme.backgroundColor
    }
    
    func footerView() -> UIView {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 70))
        customView.backgroundColor = .darkGray
        textField.backgroundColor = .gray
        let button = UIButton(frame: CGRect(x: view.frame.width * 0.7, y: 0, width: view.frame.width * 0.3, height: 70))
        button.setTitle("Send", for: .normal)
        button.addTarget(self, action: #selector(writeMessage), for: .touchUpInside)
        customView.addSubview(textField)
        customView.addSubview(button)
        return customView
    }
    
    @objc func writeMessage() {
        let message = MessageCellModel(content: textField.text ?? "",
                              created: Date(),
                              senderId: UUIDGenerator.uuid,
                              senderName: ResoucesManager().read(fileName: .title) ?? "Anon")
        FirebaseManager.writeMessage(screenId: screenId, message)
        messagesList.append(message)
        tableView.reloadData()
        textField.text = ""
    }
}
