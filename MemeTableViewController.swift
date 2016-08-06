//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by modelf on 8/5/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes : [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        tableView.reloadData()
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let meme = memes[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell") as! CustomTableCell
        cell.memeImageView?.image = meme.memedImage
        cell.memeTopLabel?.text = "\(meme.topText)"
        cell.memeBottomLabel?.text = "\(meme.botText)"
        
        return cell
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailsViewController") as! MemeDetailsViewController
        controller.selectedMeme = memes[indexPath.row]
        
        navigationController?.pushViewController(controller, animated: true)
    }

}
