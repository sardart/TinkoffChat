//
//  ViewController.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupViews()

    }
    
    func setupViews() {
        let cornerRadius = choosePhotoButton.frame.height / 2
        choosePhotoButton.layer.cornerRadius = cornerRadius
        myPhoto.layer.cornerRadius = cornerRadius
        myPhoto.layer.masksToBounds = true
        
        editButton.layer.cornerRadius = 12
        editButton.layer.borderColor = UIColor.darkGray.cgColor
        editButton.layer.borderWidth = 1.5
        
    }
    
    
    @IBAction func editTapped(_ sender: UIButton) {
        
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
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.cameraCaptureMode = .photo
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
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
    
    @IBAction func closeTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}


