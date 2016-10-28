//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by modelf on 6/11/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    var imagePicker = UIImagePickerController()
    var meme : Meme?
    var memedImage : UIImage!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBAction func dismissVC(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    let strokeAttributedText = [
        NSStrokeColorAttributeName: UIColor.black,
        NSForegroundColorAttributeName : UIColor.white,
        NSStrokeWidthAttributeName: -3.0,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ] as [String : Any]
    
    func configure() {
        
        topField.attributedText = NSAttributedString(string: topField.text!, attributes: strokeAttributedText)
        bottomField.attributedText = NSAttributedString(string: bottomField.text!, attributes: strokeAttributedText)
        
        topField.delegate = self
        bottomField.delegate = self
        imagePicker.delegate = self

//        imagePickerView.contentMode = .ScaleAspectFit
        
        if imagePickerView.image != nil {
            shareButton.isEnabled = true
        } else {
            shareButton.isEnabled = false
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        configure()

        subscribeToKeyboardNotificationShow()
 
        if let meme = meme {
            imagePickerView.image = meme.image
        }
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
            unsubscribeToKeyboardNotificationShow()
    }
    
    func subscribeToKeyboardNotificationShow() {
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MemeEditorViewController.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }

    
    func unsubscribeToKeyboardNotificationShow() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomField.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = (notification as NSNotification).userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillHide(_ notification: Notification) {
            view.frame.origin.y = 0
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if topField.text == "TOP" || bottomField.text == "BOTTOM" {
            textField.text? = ""
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if topField.text == "" {
            topField.text = "TOP"
        }
        else if bottomField.text == "" {
            bottomField.text = "BOTTOM"
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func save() {
//        if let existingMeme = meme {
//            existingMeme.topText: topField.text!
//            existingMeme.botText: bottomField.text!
//            existingMeme.image: imagePickerView.image!
//            existingMeme.memedImage: memedImage
//
//        } else {
//
//            
            let newMeme = Meme(topText: topField.text!, botText: bottomField.text!, image: imagePickerView.image!, memedImage: memedImage)
            let object = UIApplication.shared.delegate as! AppDelegate
            
            object.memes.append(newMeme)
    }
    
    func generateMemedImage() -> UIImage {
        topToolbar.isHidden = true
        bottomToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        topToolbar.isHidden = false
        bottomToolbar.isHidden = false
        
        return memedImage
    }
    
    
    @IBAction func pickAnImage(_ sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageCamera(_ sender: AnyObject) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareAction(_ sender: AnyObject) {
        

        memedImage = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returneditems, activitiesError) in
//            if (completed) {
                self.save()
                activityViewController.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
//            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
}





