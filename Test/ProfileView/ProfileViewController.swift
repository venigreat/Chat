//
//  ProfileViewController.swift
//  Test
//
//  Created by a.belyaev3 on 21.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var profileButton: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var professionTextView: UITextView!
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var secondLetterLabel: UILabel!
    @IBOutlet weak var editButton: CustomButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var gcdButton: CustomButton!
    @IBOutlet weak var operationButton: CustomButton!
    
    var titleBeforeEdit: String? = ""
    var professionBeforeEdit: String? = ""
    let manager = ResoucesManager()
    let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Public
    
    override func viewDidLoad() {
        setupDefaultNames()
        setupLabels()
        setBigLetters()
        setupProfileButton()
        setupProfilePictire()
        setupEditButton()
        setupCloseButton()
        setupTheme()
        setupActivityIndicator()
        setupSaveButtons()
        super.viewDidLoad()
        Logger.log("Frame из viewDidLoad \(editButton.frame)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Данные фрейма пересчитываются исходя из размера экрана, других элементов
        Logger.log("Frame из viewDidAppear \(editButton.frame)")
    }
    @IBAction func tapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapEditButton(_ sender: Any) {
        titleBeforeEdit = nameTextField.text
        professionBeforeEdit = professionTextView.text
        nameTextField.isUserInteractionEnabled = true
        nameTextField.backgroundColor = UIColor.gray
        professionTextView.isUserInteractionEnabled = true
        professionTextView.backgroundColor = UIColor.gray
        profileButton.isUserInteractionEnabled = true
        editButton.isHidden = true
    }
    @IBAction func tapGcdButton(_ sender: Any) {
        saveData(manager: GCDManager())
    }
    @IBAction func tapOperationsButton(_ sender: Any) {
        let profileModel = ProfileModel(name: nameTextField.text,
                                        profession: professionTextView.text,
                                        image: profileButton.image)
        saveData(manager: OperationManager(vc: self, model: profileModel))
    }
    
    @objc func tapProfileButton(_ sender: UITapGestureRecognizer) {
        ImagePickerManager().pickImage(self) { image in
            self.profileButton.image = image
            self.configureProfilePicture()
        }
    }
    @IBAction func nameTextFieldChange(_ sender: Any) {
        checkShowSaveButtons()
    }
    
    // MARK: - Private
    
    private func setupLabels() {
        professionTextView.delegate = self
        nameTextField.delegate = self
        nameTextField.text = manager.read(fileName: .title)
        professionTextView.text = manager.read(fileName: .profession)
    }
    
    private func setupProfileButton() {
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        let gesture = UITapGestureRecognizer(target: self, action: #selector (self.tapProfileButton (_:)))
        self.profileButton.addGestureRecognizer(gesture)
    }
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        view.addSubview(activityIndicator)
    }
    
    private func setupProfilePictire() {
        if let image = ResoucesManager().readImage(fileName: .avatar) {
            profileButton.image = image
        }
        configureProfilePicture()
    }
    
    private func configureProfilePicture() {
        if profileButton.image != nil {
            bigLettersSetVisible(false)
        } else {
            bigLettersSetVisible(true)
            setBigLetters()
        }
        profileButton.layer.cornerRadius = profileButton.frame.height / 2
        profileButton.clipsToBounds = true
        profileButton.bringSubviewToFront(profileButton)
        profileButton.reloadInputViews()
    }
    
    private func bigLettersSetVisible(_ state: Bool) {
        firstLetterLabel.isHidden = !state
        secondLetterLabel.isHidden = !state
    }
    
    private func setBigLetters() {
        if let userName = nameTextField.text {
            firstLetterLabel.text = String(userName.prefix(1))
            let nameArray = userName.split(separator: " ")
            if nameArray.count > 1 {
                secondLetterLabel.text = String(nameArray[1].prefix(1))
            }
        }
    }
    
    private func setupEditButton() {
        editButton.layer.cornerRadius = 16
    }
    
    private func setupCloseButton() {
        closeButton.clipsToBounds = true
        closeButton.contentMode = .scaleAspectFill
        closeButton.setBackgroundImage(UIImage(named: "close"), for: .normal)
    }
    
    private func setupSaveButtons() {
        gcdButton.isHidden = true
        operationButton.isHidden = true
    }
    
    private func setupTheme() {
        let theme = ThemeManager().getTheme()
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: theme.textColor]
        view.backgroundColor = theme.backgroundColor
        nameTextField.textColor = theme.textColor
        professionTextView.textColor = theme.textColor
    }
    
    private func setupDefaultNames() {
        if !self.manager.isFileExist(file: .title) {
            self.manager.write(vc: self, value: "My Name", fileName: .title)
        }
        if !self.manager.isFileExist(file: .profession) {
            self.manager.write(vc: self, value: "My profession", fileName: .profession)
        }
        
    }
    
    private func saveData(manager: ISaveData) {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        let profileModel = ProfileModel(name: nameTextField.text,
                                        profession: professionTextView.text,
                                        image: profileButton.image)
        
        manager.saveUser(vc: self, model: profileModel) {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.isHidden = true
            self.setBigLetters()
            
            self.nameTextField.isUserInteractionEnabled = false
            self.nameTextField.backgroundColor = UIColor.clear
            self.professionTextView.isUserInteractionEnabled = false
            self.professionTextView.backgroundColor = UIColor.clear
            self.profileButton.isUserInteractionEnabled = false
            self.editButton.isHidden = false
            self.gcdButton.isHidden = true
            self.operationButton.isHidden = true
            self.present(Alert(title: "Загрузка успешно завершена", message: nil).alert,
                         animated: true,
                         completion: nil)
        }
    }
    
    private func checkShowSaveButtons() {
        if nameTextField.text == titleBeforeEdit && professionTextView.text == professionBeforeEdit {
            gcdButton.isHidden = true
            operationButton.isHidden = true
        } else {
            gcdButton.isHidden = false
            operationButton.isHidden = false
        }
    }
}

extension ProfileViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkShowSaveButtons()
    }
}
