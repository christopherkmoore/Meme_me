//
//  ViewController.swift
//  MemeMe
//
//  Created by modelf on 6/11/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let strokeAttributedText = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -1.0,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
        
        
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        subscribeToKeyboardNotificationShow()
        subscribeToKeyboardNotificationHide()

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeToKeyboardNotificationsHide()
        unsubscribeToKeyboardNotificationShow()
    }
    
    func subscribeToKeyboardNotificationShow() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
    }
    func subscribeToKeyboardNotificationHide() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotificationShow() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeToKeyboardNotificationsHide() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if bottomField.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        print(keyboardSize)
        print(keyboardSize.CGRectValue().height)
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topField.attributedText = NSAttributedString(string: topField.text!, attributes: strokeAttributedText)
        bottomField.attributedText = NSAttributedString(string: bottomField.text!, attributes: strokeAttributedText)
        topField.delegate = self
        bottomField.delegate = self
        imagePickerView.contentMode = .ScaleAspectFit
        
        
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text? = ""
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    @IBAction func pickAnImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageCamera(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    
    struct Meme {
        var topText : String
        var botText : String
        var image : UIImage
        var memedImage : UIImage
        
        init (topText: String, botText: String, image: UIImage, memedImage: UIImage) {
            self.topText = topText
            self.botText = botText
            self.image = image
            self.memedImage = memedImage
        }
    }
    

    
    @IBAction func shareAction(sender: AnyObject) {
        
        func generateMemedImage() -> UIImage {
            topToolbar.hidden = true
            bottomToolbar.hidden = true
            
            UIGraphicsBeginImageContext(self.view.frame.size)
            view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
            let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            topToolbar.hidden = false
            bottomToolbar.hidden = false
        
            return memedImage
        }
        
        let contextSavedMeme = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [contextSavedMeme], applicationActivities: nil)
        presentViewController(activityViewController, animated: true, completion: nil)
        
        func save() {
            let meme = Meme(topText: topField.text!, botText: bottomField.text!, image: imagePickerView.image!, memedImage: contextSavedMeme)
            
        }
        
    }
    
    




 
}

