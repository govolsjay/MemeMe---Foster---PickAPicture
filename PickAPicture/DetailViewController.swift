//
//  DetailViewController.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/29/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    //these are the varibles that align to the three items on the detail viewcontroller
    @IBOutlet weak var DetailImage: UIImageView!
    @IBOutlet weak var DetailTopText: UILabel!
    @IBOutlet weak var DetailBottomText: UILabel!
    //here we are establishing three varibles that will bring over the information from the table view controller
    var Label1: String!
    var Label2: String!
    var Image1: UIImage!
    
    

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
 
    //we establish three varibles in the table view controller, and this equates our viewable varibles to those sent over.
    override func viewDidLoad() {
        super.viewDidLoad()

        DetailTopText.text = Label1
        DetailBottomText.text = Label2
        DetailImage.image = Image1
    }

}
