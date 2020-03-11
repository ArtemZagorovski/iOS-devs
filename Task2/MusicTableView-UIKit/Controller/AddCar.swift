//
//  AddCar.swift
//  MusicTableView-UIKit
//
//  Created by Артем  on 2/13/20.
//  Copyright © 2020 Artem Zagorovski. All rights reserved.
//

import UIKit
import RealmSwift


class AddCar: UIViewController {
    
    
    var currentCar: Car!
    var imageIsChanged = false
    
    
    @IBOutlet weak var addCarImage: UIImageView!
    @IBOutlet weak var addBrand: UITextField!
    @IBOutlet weak var addModel: UITextField!
    @IBOutlet weak var addCost: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEditScreen()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @IBAction func changeImage(_ sender: UIButton) {
        
        let camIcon = #imageLiteral(resourceName: "plus-512")
        let photoIcon = #imageLiteral(resourceName: "picture-512")
        
        let actionSheet = UIAlertController(title: nil,
                                            message: nil,
                                            preferredStyle: .actionSheet)
        let camAction = UIAlertAction(title: "Take a shot", style: .default) { _ in
            self.chooseImagePicker(source: .camera)
        }
        camAction.setValue(camIcon, forKey: "image")
        camAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let photoAction = UIAlertAction(title: "Choose photo", style: .default) { _ in
            self.chooseImagePicker(source: .photoLibrary)
        }
        photoAction.setValue(photoIcon, forKey: "image")
        photoAction.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        actionSheet.addAction(camAction)
        actionSheet.addAction(photoAction)
        actionSheet.addAction(cancelAction)
        present(actionSheet, animated: true)
        
    }
    
    private func setupEditScreen() {
        if currentCar != nil {
            
            imageIsChanged = true
            
            guard let data = currentCar?.imageData, let image = UIImage(data: data) else {return}
            
            addCarImage.image = image
            addCarImage.contentMode = .scaleAspectFill
            addBrand.text = currentCar?.brand
            addModel.text = currentCar?.model
            addCost.text = String(currentCar.cost)
        }
    }
    
    func saveCar() {
        
        let image = imageIsChanged ? addCarImage.image : #imageLiteral(resourceName: "images")
        let imageData = image?.pngData()
            
        let newCar = Car(brand: addBrand.text!,
                         model: addModel.text,
                         cost: Int(addCost.text!),
                         imageData: imageData)
        
        if currentCar != nil {
            try! realm.write {
                currentCar?.brand = newCar.brand
                currentCar?.model = newCar.model
                currentCar?.cost = newCar.cost
                currentCar.imageData = newCar.imageData
            }
        } else {
            StorageManager.saveObject(newCar)
        }
    }
    
    @IBAction func sharePhoto(_ sender: Any) {
        
        guard let data = currentCar?.imageData, let image = UIImage(data: data) else {return}

        let shareController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
    
}

extension AddCar: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        addCarImage.image = info[.editedImage] as? UIImage
        addCarImage.contentMode = .scaleAspectFill
        addCarImage.clipsToBounds = true
        
        imageIsChanged = true
        
        dismiss(animated: true)
    }
}

extension AddCar: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
