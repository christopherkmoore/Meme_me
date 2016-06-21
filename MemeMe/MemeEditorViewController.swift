//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by modelf on 6/11/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UITextFieldDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var topField: UITextField!
    @IBOutlet weak var bottomField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    let strokeAttributedText = [
        NSStrokeColorAttributeName: UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSStrokeWidthAttributeName: -3.0,
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!
    ]
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        
        
        topField.attributedText = NSAttributedString(string: topField.text!, attributes: strokeAttributedText)
        bottomField.attributedText = NSAttributedString(string: bottomField.text!, attributes: strokeAttributedText)

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
            view.frame.origin.y = getKeyboardHeight(notification) * -1
        }
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if bottomField.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topField.delegate = self
        bottomField.delegate = self
        imagePickerView.contentMode = .ScaleAspectFit
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if topField.text == "TOP" || bottomField.text == "BOTTOM" {
            textField.text? = ""
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if topField.text == "" {
            topField.text = "TOP"
        }
        else if bottomField.text == "" {
            bottomField.text = "BOTTOM"
        }
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
        
        activityViewController.completionWithItemsHandler = {
            (activityType, completed, returneditems, activitiesError) in
            if completed {
                save()
            }
        }
    }
}

    extension MemeEditorViewController {
        
        func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                imagePickerView.image = image
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
 


