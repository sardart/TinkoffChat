//
//  ViewController.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate, DataManagerDelegate {
    @IBOutlet var aboutMeTextView: UITextView!
    
    @IBOutlet var operationButton: UIButton!
    @IBOutlet var gcdButton: UIButton!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var choosePhotoButton: UIButton!
    @IBOutlet var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var editButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var imagePicker = UIImagePickerController()
    var gcdDataManager = GCDDataManager()
    var operationDataManager = OperationDataManager()
    
    
    var initialImage = UIImage(named: "placeholder-user")
    var initialName = "Artur Sardaryan"
    var initailAboutMe = "iOS Developer.\nWill code for food."
    
    
    var nameChanged = false
    var aboutMeChanged = false
    var savingDissabled = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextField.text = initialName
        self.myPhoto.image = initialImage
        self.aboutMeTextView.text = initailAboutMe
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        
        setupViews()
        
        loadSavedImage()
        loadSavedText()
        
        imagePicker.delegate = self
        nameTextField.delegate = self
        aboutMeTextView.delegate = self
        gcdDataManager.delegate = self
        operationDataManager.delegate = self
        
        configNormalMode()
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            self.view.frame.origin.y = -keyboardRectangle.height
        }
        
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        self.view.frame.origin.y = 0
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if savingDissabled && textField.text != self.initialName {
            enableSaving()
        }
        return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if savingDissabled && self.aboutMeTextView.text != self.initailAboutMe {
            enableSaving()
        }
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    
    func configNormalMode() {
        gcdButton.isHidden = true
        operationButton.isHidden = true
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
        operationButton.isHidden = false
        gcdButton.isHidden = false
        nameTextField.borderStyle = .roundedRect
        nameTextField.isUserInteractionEnabled = true
        aboutMeTextView.isUserInteractionEnabled = true
        choosePhotoButton.isHidden = false
        disableSaving()
    }
    
    func disableSaving() {
        savingDissabled = true
        gcdButton.alpha = 0.5
        gcdButton.isEnabled = false
        operationButton.alpha = 0.5
        operationButton.isEnabled = false
    }
    
    func enableSaving() {
        savingDissabled = false
        gcdButton.alpha = 1
        gcdButton.isEnabled = true
        operationButton.alpha = 1
        operationButton.isEnabled = true
    }
    
    @IBAction func editTapped(_ sender: UIButton) {
        configEditMode()
    }
    
    @IBAction func choosePhotoTapped(_ sender: UIButton) {
        showActionSheet()
        
    }
    
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
    
    
    func takePhoto() {
        if savingDissabled {
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
        if savingDissabled {
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
    
    func saveData(with dataManager: DataManager) {
        if let name = nameTextField.text,
            name != initialName {
            dataManager.saveText(name, key: "name")
            initialName = name
        }
        if let aboutMe = aboutMeTextView.text,
            aboutMe != initailAboutMe {
            dataManager.saveText(aboutMe, key: "aboutMe")
            initailAboutMe = aboutMe
        }
        
        if let image = myPhoto.image,
            initialImage != image {
            activityIndicator.startAnimating()
            disableSaving()
            initialImage = image
            let filename = self.getDocumentsDirectory().appendingPathComponent("avatar.png")
            dataManager.saveImage(image, path: filename)
        } else {
            showAlert(title: "Success", message: "Data successfully saved", success: true, sender: dataManager)
        }
        
        
    }
    
    
    func loadSavedText() {
        DispatchQueue.main.async {
            if let name = self.gcdDataManager.loadText(key: "name") {
                self.nameTextField.text = name
                self.initialName = name
            }
            if let aboutMe = self.gcdDataManager.loadText(key: "aboutMe") {
                self.aboutMeTextView.text = aboutMe
                self.initailAboutMe = aboutMe
            }
        }
    }
    
    func loadSavedImage() {
        DispatchQueue.main.async {
            let filename = self.getDocumentsDirectory().appendingPathComponent("avatar.png")
            if let image = self.gcdDataManager.loadImage(path: filename) {
                self.myPhoto.image = image
                self.initialImage = image
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func operationTapped(_ sender: Any) {
        saveData(with: operationDataManager)
    }
    
    @IBAction func GCDTapped(_ sender: Any) {
        saveData(with: gcdDataManager)
    }
    
    func showAlert(title: String, message: String, success: Bool, sender: DataManager) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.tintColor = UIColor.black
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            self.configNormalMode()
            self.activityIndicator.stopAnimating()
        }
        
        if !success {
            let repeatAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
                self.saveData(with: sender)
            }
            alertController.addAction(repeatAction)
        }
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    deinit {
        buttons = nil;
    }
}


