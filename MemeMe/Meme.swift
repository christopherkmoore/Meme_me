//
//  Meme.swift
//  MemeMe
//
//  Created by modelf on 8/5/16.
//  Copyright © 2016 modelf. All rights reserved.
//

import Foundation
import UIKit

class Meme: NSObject {
    
    var topText: String
    var botText: String
    var image: UIImage
    var memedImage: UIImage
    
    init(topText: String, botText: String, image: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.botText = botText
        self.image = image
        self.memedImage = memedImage
        
    }
}