//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by modelf on 8/5/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!

    
    var memes : [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.reloadData()
    }


    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> CustomMemeCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCellIdentifier", forIndexPath: indexPath) as! CustomMemeCell
        let meme = memes[indexPath.item]
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.botText
        let imageView = UIImageView(image: meme.image)
        cell.backgroundView = imageView
        
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let controller = storyboard?.instantiateViewControllerWithIdentifier("MemeDetailsViewController") as! MemeDetailsViewController
        controller.selectedMeme = memes[indexPath.item]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

}