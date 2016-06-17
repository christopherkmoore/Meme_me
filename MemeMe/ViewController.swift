//
//  ViewController.swift
//  MemeMe
//
//  Created by modelf on 6/11/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
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
//    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(true)
//        self.subscribeToKeyboardNotifications()
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(true)
//        self.unsubscribeToKeyboardNotifications()
//    }
//    
//    func subscribeToKeyboardNotifications() {
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
//    }
//    
//    func unsubscribeToKeyboardNotifications() {
//        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
//    }
//    
//    func keyboardWillShow(notification: NSNotification) {
//        view.frame.origin.y -= getKeyboardHeight(notification)
//    }
//    
//    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
//        let userInfo = notification.userInfo
//        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
//        return keyboardSize.CGRectValue().height
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        topField.attributedText = NSAttributedString(string: topField.text!, attributes: strokeAttributedText)
        bottomField.attributedText = NSAttributedString(string: bottomField.text!, attributes: strokeAttributedText)


        
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        // Do any additional setup after loading the view, typically from a nib.
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
    
    //imagePickerView.image! = imagePicker.delegate?.imagePickerController(UIImagePickerController, didFinishPickingMediaWithInfo: info[UIImagePickerControllerOriginalImage]) as? UIImage
    
}

