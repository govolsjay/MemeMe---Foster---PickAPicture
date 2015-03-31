//
//  Meme.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/26/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import Foundation
import UIKit


//this builds the struct for our array Meme, with three characteristics top bottom and image
struct Meme {
    
    let top1: String
    let bottom1: String
    let imageName: UIImage
    
    init(name: String, name2: String, imageName: UIImage)
    {
        self.top1 = name
        self.bottom1 = name2
        self.imageName = imageName
    }



}



