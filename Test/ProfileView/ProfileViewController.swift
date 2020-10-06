//
//  ProfileViewController.swift
//  Test
//
//  Created by a.belyaev3 on 21.09.2020.
//  Copyright © 2020 a.belyaev3. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileButton: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    @IBOutlet weak var firstLetterLabel: UILabel!
    @IBOutlet weak var secondLetterLabel: UILabel!
    @IBOutlet weak var saveButton: CustomButton!
    @IBOutlet weak var closeButton: UIButton!
    
    //MARK: - Public
    
    override func viewDidLoad() {
        setupLabels()
        setBigLetters()
        setupProfileButton()
        setupProfilePictire()
        setupSaveButton()
        setupCloseButton()
        super.viewDidLoad()
        Logger.log("Frame из viewDidLoad \(saveButton.frame)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Данные фрейма пересчитываются исходя из размера экрана, других элементов
        Logger.log("Frame из viewDidAppear \(saveButton.frame)")
    }
    @IBAction func tapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func tapProfileButton(_ sender:UITapGestureRecognizer) {
        ImagePickerManager().pickImage(self) { image in
            self.profileButton.image = image
            self.setupProfilePictire()
        }
    }
    
    //MARK: - Private
    
    private func setupLabels() {
        nameLabel.text = "Belyaev Andrey"
        professionLabel.numberOfLines = 2
        professionLabel.text = "Very long profession Very long profession Very long profession Very long profession"
    }
    
    private func setupProfileButton() {
        NSLayoutConstraint.activate([
            profileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        let gesture = UITapGestureRecognizer(target: self, action:  #selector (self.tapProfileButton (_:)))
        self.profileButton.addGestureRecognizer(gesture)
    }
    
    private func setupProfilePictire() {
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
        if let userName = nameLabel.text {
            firstLetterLabel.text = String(userName.prefix(1))
            let nameArray = userName.split(separator: " ")
            secondLetterLabel.text = String(nameArray[1].prefix(1))
        }
    }
    
    private func setupSaveButton() {
        saveButton.layer.cornerRadius = 16
    }
    
    private func setupCloseButton() {
        closeButton.clipsToBounds = true
        closeButton.contentMode = .scaleAspectFill
        closeButton.setBackgroundImage(UIImage(named: "cancel.png"), for: .normal)
    }
}
