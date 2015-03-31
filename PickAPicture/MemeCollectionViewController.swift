//
//  MemeCollectionViewController.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/28/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//
import Foundation
import UIKit

class MemeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var collectionButton: UITabBarItem!
    @IBOutlet weak var tableButton: UITabBarItem!
    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var arrayOfMemes: [Meme]!
    

    
    override func viewDidAppear(animated: Bool) {
    }
    
    
    //these are lines that point our array Meme back to the appdelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        arrayOfMemes = appDelegate.arrayOfMemes
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayOfMemes.count
    }
    
    //these lines of code will help the collection view understand what to populate within the cell
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell: MemeCollectionCell = collectionView.dequeueReusableCellWithReuseIdentifier("MemeCollectionCell", forIndexPath: indexPath) as MemeCollectionCell
 
        let meme = self.arrayOfMemes[indexPath.row]
        cell.setCell(meme.top1, bottomTextForCell: meme.bottom1, imageForCell: meme.imageName)
        return cell
    }



}
