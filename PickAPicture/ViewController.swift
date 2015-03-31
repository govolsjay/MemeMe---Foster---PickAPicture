//
//  ViewController.swift
//  PickAPicture
//
//  Created by Jay Foster on 3/21/15.
//  Copyright (c) 2015 JFYF. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UITextFieldDelegate {


    //these variables are all on the main Editor page
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var albumButton: UIBarButtonItem!
    @IBOutlet weak var sentMemesButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    //text field delegates
    let topDelegate = topTextFieldDelegate()
    let bottomDelegate = bottomTextFieldDelegate()
  
    
    
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        //this code keeps the action button disabled until a picture is choosen
        if imagePickerView.image == nil {
        actionButton.enabled = false
            } else {
            actionButton.enabled = true
            }
 
        //this helps us move up the screen when the keyboard appears - by subscribing to the notification
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
        self.subscribeToKeyboardDisappearNotifications()
    }
    
    
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.unsubscribeFromKeyboardDisappearNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:"    , name: UIKeyboardWillShowNotification, object: nil)
    }
    
    func subscribeToKeyboardDisappearNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:"    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardDisappearNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
   
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        if topText.isFirstResponder()  {    //this line of code helps us in landscape mode, where we don't want the screen to shift if we are editing the top text.
            return 0
        } else {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
        }
    }
    
    
    //lots of code within that establishes the font attributes for our MEME font
    override func viewDidLoad() {
        super.viewDidLoad()
        self.topText.delegate = topDelegate
        self.bottomText.delegate = bottomDelegate
        
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center
 
        let startingAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSStrokeColorAttributeName: UIColor.blackColor(),NSFontAttributeName: UIFont(name: "Helveticaneue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: 3.0]

        var topTextAttributes = NSAttributedString(string: topText.text, attributes: startingAttributes)
        var bottomTextAttributes = NSAttributedString(string: bottomText.text, attributes: startingAttributes)
        topText.attributedText = topTextAttributes
        bottomText.attributedText = bottomTextAttributes
    }


    
    
        
        //pick from album
        @IBAction func pickAnImageFromAlbum (sender: AnyObject) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
        
        //pick from camera
        @IBAction func pickAnImageFromCamera (sender: AnyObject) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(imagePicker, animated: true, completion: nil)
    }

    
    
    //this sets up the selected picture we have chosen to use
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
        imagePickerView.image = image
    }
    
    
    
    //someone has touched the top text, and it blanks it out if this is the first typing entry
    @IBAction func tapTopText(sender: AnyObject) {
        if topText.text == "TOP" {
        topText.text = ""
        }
    }

    
    //someone has touched the bottom text, and it blanks it out if this is the first typing entry
    @IBAction func tapBottomText(sender: AnyObject) {
        if bottomText.text == "BOTTOM" {
        bottomText.text = ""
        }
    }
    

    
    @IBAction func setUpMemes() {
        //Create the meme
        var meme1 = Meme(name: topText.text, name2: bottomText.text, imageName: generateMemedImage())
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        appDelegate.arrayOfMemes.append(meme1)
    }
    


    @IBAction func shareMeme(sender: AnyObject) {
    //builds the meme first
    setUpMemes()
    //sets up the file to email/save/whatever with the use of the activity view controller
    let firstActivityItem = generateMemedImage()
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [firstActivityItem], applicationActivities: nil)
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    
    

    func generateMemedImage() -> UIImage
    {
        bottomToolbar.hidden = true
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        bottomToolbar.hidden = false

        return memedImage
    }
    
    
    
    //when someone touches cancel, it resets the top and bottom text and removes the picture
    @IBAction func cancel(){
        imagePickerView.image = nil
        topText.text = "TOP"
        bottomText.text = "BOTTOM"
        topText.textAlignment = .Center
        bottomText.textAlignment = .Center

        let startingAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor(), NSStrokeColorAttributeName: UIColor.blackColor(),NSFontAttributeName: UIFont(name: "Helveticaneue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: 3.0]
        var topTextAttributes = NSAttributedString(string: topText.text, attributes: startingAttributes)
        var bottomTextAttributes = NSAttributedString(string: bottomText.text, attributes: startingAttributes)
        topText.attributedText = topTextAttributes
        bottomText.attributedText = bottomTextAttributes
    }
    
        
     

}

