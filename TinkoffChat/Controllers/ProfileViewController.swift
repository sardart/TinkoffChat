//
//  ViewController.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, ProfileDataManagerDelegate {
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var aboutMeTextView: UITextView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker = UIImagePickerController()

    var profileData: ProfileData?
    let profileDataManager = ProfileDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        setupViews()
        coreDataLoad()
        configNormalMode()

        imagePicker.delegate = self
        nameTextField.delegate = self
        aboutMeTextView.delegate = self
        profileDataManager.delegate = self
    }
    
    func setupViews() {
        
        let cornerRadius = choosePhotoButton.frame.height / 2
        choosePhotoButton.layer.cornerRadius = cornerRadius
        myPhoto.layer.cornerRadius = cornerRadius
        myPhoto.layer.masksToBounds = true
        
        self.aboutMeTextView.layer.borderColor = UIColor.gray.cgColor
        self.aboutMeTextView.layer.borderWidth = 1.5
        self.aboutMeTextView.layer.cornerRadius = 12
        
        for button in buttons {
            button.layer.cornerRadius = 12
            button.layer.borderColor = UIColor.darkGray.cgColor
            button.layer.borderWidth = 1.5
        }
    }
    
    // MARK: - Text input
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame.origin.y = -keyboardRectangle.height
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if saveButton.isEnabled == false {
            enableSaving()
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            if saveButton.isEnabled == false {
                enableSaving()
            }
            return false
        }
        return true
    }
    
    // MARK: - Editing mode
    
    func configNormalMode() {
        saveButton.isHidden = true
        nameTextField.borderStyle = .none
        nameTextField.isUserInteractionEnabled = false
        aboutMeTextView.isUserInteractionEnabled = false
        editButton.isHidden = false
        choosePhotoButton.isHidden = true
    }
    
    func configEditMode() {
        aboutMeTextView.resignFirstResponder()
        nameTextField.resignFirstResponder()
        editButton.isHidden = true
        saveButton.isHidden = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.isUserInteractionEnabled = true
        aboutMeTextView.isUserInteractionEnabled = true
        choosePhotoButton.isHidden = false
        disableSaving()
    }
    
    func disableSaving() {
        saveButton.alpha = 0.5
        saveButton.isEnabled = false
    }
    
    func enableSaving() {
        saveButton.alpha = 1
        saveButton.isEnabled = true
    }
    
    // MARK: - Profile photo editing
    
    func takePhoto() {
        if saveButton.isEnabled == false {
            enableSaving()
        }
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if saveButton.isEnabled == false {
            enableSaving()
        }
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        myPhoto.contentMode = .scaleAspectFit
        myPhoto.image = chosenPhoto
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Data Saving

    func coreDataSaving() {
        self.profileDataManager.save(name: nameTextField.text,
                                     aboutMe: aboutMeTextView.text,
                                     photo: myPhoto.image)
    }
    
    func willStartSaving() {
        self.activityIndicator.startAnimating()
        self.view.alpha = 0.5
        self.view.isUserInteractionEnabled = false
    }
    
    func didEndSaving() {
        self.activityIndicator.stopAnimating()
        self.view.alpha = 1
        self.view.isUserInteractionEnabled = true
        self.configNormalMode()
    }
    
    // MARK: - Data Loading

    func coreDataLoad() {
        let tuple = profileDataManager.load()
        
        self.nameTextField.text = tuple?.0
        self.aboutMeTextView.text = tuple?.1
        self.myPhoto.image = tuple?.2
    }
    
    // MARK: - @IBActions
    
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        coreDataSaving()
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        configEditMode()
    }
    
    @IBAction func choosePhotoTapped(_ sender: UIButton) {
        showActionSheet()
    }
    
    // MARK: - Alerts

    func showActionSheet() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let takePhotoAction = UIAlertAction(title: "Take photo", style: .default) { (action) in
            self.takePhoto()
        }
        let openGalleryAction = UIAlertAction(title: "Choose from Gallery", style: .default) { (action) in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(takePhotoAction)
        actionSheet.addAction(openGalleryAction)
        actionSheet.addAction(cancelAction)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
}


