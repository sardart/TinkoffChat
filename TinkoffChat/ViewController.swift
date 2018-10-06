//
//  ViewController.swift
//  smartChat
//
//  Created by Artur on 23/09/2018.
//  Copyright © 2018 Artur Sardaryan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var myPhoto: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var choosePhotoButton: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        print("editButton.frame = \(editButton.frame)")
        // падаем, потому что контроллер пока не загрузил инфу из сториборда и не знает что у него есть кнопка editButton
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stateControl(methodName: #function)
        
        imagePicker.delegate = self
        print("editButton.frame = \(editButton.frame)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stateControl(methodName: #function)
        
        setupViews()
        
        print("editButton.frame = \(editButton.frame)")
        // результат отличается так как во viewDidLoad мы еще не знаем точные размеры всех вьшек с учетом констрейнтов
        
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
        print("Choose avatar")
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
    
    
    
    
    
    
    
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stateControl(methodName: #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stateControl(methodName: #function)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        stateControl(methodName: #function)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        stateControl(methodName: #function)
    }
    
    override func loadView() {
        super.loadView()
        stateControl(methodName: #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        stateControl(methodName: #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        stateControl(methodName: #function)
    }
    
    
}


