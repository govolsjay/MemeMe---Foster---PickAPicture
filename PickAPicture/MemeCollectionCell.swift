//
//  MemeCollectionCell.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/28/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit

class MemeCollectionCell: UICollectionViewCell {
    
    
    //this is a custom class which allows us to build a cell that contains what we want it to show
    //builds our three variables
    @IBOutlet weak var topTextForCell: UILabel!
    @IBOutlet weak var bottomTextForCell: UILabel!
    @IBOutlet weak var imageForCell: UIImageView!
    
    //this function helps associate the three variables to the contents it needs - this "setCell" function will be used in other ViewControllers
    func setCell(topTextForCell: String, bottomTextForCell: String, imageForCell: UIImage)
    {
        self.topTextForCell.text = topTextForCell
        self.bottomTextForCell.text = bottomTextForCell
        self.imageForCell.image = imageForCell
    }
    
    
}
