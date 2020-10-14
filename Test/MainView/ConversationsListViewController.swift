//
//  ViewController.swift
//  Test
//
//  Created by a.belyaev3 on 18.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

struct ConversationsWithTypeList {
    let type: String
    let list: [ConversationCellModel]
}

class ConversationsListViewController: UIViewController {
    
    let formatter = DateFormatter()
    let conversationList = DataManager().getChatListData()
    let themesViewController = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "themesViewController") as! ThemesViewController
            

    override func viewDidLoad() {
        super.viewDidLoad()
        themesViewController.delegate = self
        setupTheme()
        view.addSubview(tableView)
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
    
    private let cellIdentifier = String(describing: ConversationsCell.self)
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.frame, style: .plain)
        tableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Conversation" {
            guard let viewController = segue.destination as? ConversationViewController,
            let index = sender as? IndexPath else { return }
            viewController.name = conversationList[index.section].list[index.row].name
        }
    }
    
    @IBAction func tapThemesButton(_ sender: Any) {
        themesViewController.callback = { [weak self] in
            self?.setupTheme() }
        // weak избавляет от retain cycle
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    private func setupTheme() {
        let theme = ThemeManager.getTheme()
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return conversationList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationList[section].list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ConversationsCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: conversationList[indexPath.section].list[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return conversationList[section].type
    }
}

extension ConversationsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "Conversation", sender: indexPath)
    }
}

extension ConversationsListViewController: ChangeThemeDelegate {
    func changeTheme(sender: Any) {
        setupTheme()
    }
}
