//
//  MemeTableViewController.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/28/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit

class MemeTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableButton: UITabBarItem!
    @IBOutlet weak var myTableView: UITableView!
    
    var arrayOfMemes: [Meme]!

    override func viewDidAppear(animated: Bool) {
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //this code points our Meme back to the appdelegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        arrayOfMemes = appDelegate.arrayOfMemes
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfMemes.count
    }
    
    //this code builds the data that will be used to form each row in the table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: CustomCell = tableView.dequeueReusableCellWithIdentifier("MemeCell") as CustomCell
        //this just sets two different tyes ofbackdrop colors for the rows - gray and lightgray
        if indexPath.row % 2 == 0
        {
            cell.backgroundColor = UIColor.lightGrayColor()
            }else{
            cell.backgroundColor = UIColor.grayColor()
        }
        
        let meme = self.arrayOfMemes[indexPath.row]
        cell.setCell(meme.top1, bottomTextForCell: meme.bottom1, imageForCell: meme.imageName)
        return cell
    }
    
    

    //this code establishes what values will be carried over to the detail page once a row is touched
    func tableView(TableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {

        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController")! as DetailViewController
        //detailController.Label1 = self.arrayOfMemes[indexPath.row].top1
        //detailController.Label2 = self.arrayOfMemes[indexPath.row].bottom1
        detailController.Image1 = self.arrayOfMemes[indexPath.row].imageName
        self.navigationController!.pushViewController(detailController, animated: true)
    }



}

        
        
