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
        return (UIApplication.shared.delegate as! AppDelegate).memes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let space: CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        collectionView?.reloadData()
        self.tabBarController?.tabBar.isHidden = false
    }


    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> CustomMemeCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomMemeCellIdentifier", for: indexPath) as! CustomMemeCell
        let meme = memes[(indexPath as NSIndexPath).item]
        cell.memedImage.image = meme.image
        cell.topText.text = meme.topText
        cell.bottomText.text = meme.botText
        
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
        controller.selectedMeme = memes[(indexPath as NSIndexPath).item]
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }

}
