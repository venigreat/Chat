//
//  ViewController.swift
//  Test
//
//  Created by a.belyaev3 on 18.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ConversationsListViewController: UIViewController {
    
    let formatter = DateFormatter()
    var conversationList: [ConversationCellModel] = []
    let themesViewController = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(withIdentifier: "themesViewController") as? ThemesViewController
        ?? ThemesViewController()

    var refreshControl = UIRefreshControl()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        readFromFirebase()
        themesViewController.delegate = self
        setupTheme()
        setupRepreshController()
        tableView.addSubview(refreshControl)
        view.addSubview(self.tableView)
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
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        Logger.log(#function)
        super.viewDidDisappear(animated)
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
            viewController.name = conversationList[index.row].name
            viewController.screenId = conversationList[index.row].identifier
            tableView.deselectRow(at: index, animated: true)
        }
    }
    
    @IBAction func tapThemesButton(_ sender: Any) {
        themesViewController.callback = { [weak self] in
            self?.setupTheme()
        }
        // weak избавляет от retain cycle
        navigationController?.pushViewController(themesViewController, animated: true)
    }
    
    private func setupTheme() {
        let theme = ThemeManager().getTheme()
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
    }
    
    private func setupRepreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
    }
    
    private func readFromFirebase() {
        FirebaseManager.readChannels { chatsList in
            self.conversationList = chatsList
            self.tableView.reloadData()
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        readFromFirebase()
        refreshControl.endRefreshing()
    }
    
    @IBAction func tapAddChanelButton(_ sender: Any) {
        let alert = UIAlertController(title: "Add channel",
                                      message: "Add channel with chosen title",
                                      preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.text = "New chanel"
        }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0]
            FirebaseManager.writeChannel(title: textField?.text)
            self.readFromFirebase()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ConversationsListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversationList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier,
                                                       for: indexPath) as? ConversationsCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: conversationList[indexPath.row])

        return cell
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
