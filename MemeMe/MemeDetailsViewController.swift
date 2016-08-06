//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by modelf on 8/5/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailsViewController: UIViewController {
    
//    @IBOutlet weak var dismissButton: UIBarButtonItem!
    @IBOutlet weak var memeImage: UIImageView!
//    @IBOutlet weak var trashButton: UIBarButtonItem!
    

    
    var selectedMeme: Meme!
    var memes : [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        memeImage.image = selectedMeme.memedImage
        self.tabBarController?.tabBar.hidden = true
    }
    
    
    
//    @IBAction func editMeme(sender: AnyObject) {
//        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
//        
//
//        
//        presentViewController(controller, animated: true, completion: nil)
//    }
    
//    @IBAction func deleteMeme (sender: AnyObject) {
//       let object = UIApplication.sharedApplication().delegate as! AppDelegate
//        
//        
//        
//        if let index = object.memes.indexOf(selectedMeme) {
//            object.memes.removeAtIndex(index)
//            navigationController?.popViewControllerAnimated(true)
//        }
//    }
    
    
}