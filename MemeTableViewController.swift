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
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.isHidden = false
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = memes[(indexPath as NSIndexPath).row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") as! CustomTableCell
        cell.memeImageView?.image = meme.memedImage
        cell.memeTopLabel?.text = "\(meme.topText)"
        cell.memeBottomLabel?.text = "\(meme.botText)"
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        controller.selectedMeme = memes[(indexPath as NSIndexPath).row]
        
        navigationController?.pushViewController(controller, animated: true)
    }

}
