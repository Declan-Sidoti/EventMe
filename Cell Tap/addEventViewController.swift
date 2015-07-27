//
//  addEventViewController.swift
//  Cell Tap
//
//  Created by Declan sidoti on 7/13/15.
//  Copyright (c) 2015 Declan Sidoti. All rights reserved.
//

import UIKit

class addEventViewController: UIViewController, UITextViewDelegate {

    var photoTakingHelper: PhotoTakingHelper?
    
    @IBOutlet var eventCode: UILabel!
    @IBOutlet var placeholderLabel: UILabel!
    @IBOutlet var eventPicture: UIButton!
    @IBOutlet var eventTitle: UITextField!
    @IBOutlet var eventDescription: UITextView!
    
    @IBOutlet var saveButton: UIButton!
    var image : UIImage?
    
    
    @IBOutlet var codeButton: UIButton!
    var randomString = ""
    @IBAction func gererateCode(sender: AnyObject) {
    
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        randomString = ""
        
        for _ in 0..<6 {
            var length = UInt32 (count(letters))
            var rand = arc4random_uniform(length)
            randomString += String(letters[Int(rand)])
        }
        
        eventCode.text = "Code: " + (randomString as String)
        codeButton.enabled = false
        saveButton.hidden = false
        UIPasteboard.generalPasteboard().string = randomString
    }
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if(identifier == "saveEvent"){
            if(eventTitle.text == "" || eventDescription.text == ""){
                return false
            }
        }
        
        return true
    }
    @IBAction func saveToParse(sender: AnyObject) {
        
        if (eventTitle.text == ""){
            eventTitle.layer.borderColor = UIColor.redColor().CGColor
            eventTitle.layer.borderWidth = 1
            eventTitle.layer.cornerRadius = 5
        }
        if (eventDescription.text == ""){
            eventDescription.layer.borderColor = UIColor.redColor().CGColor
        }
        
            
        if (eventTitle.text != "" && eventDescription.text != "") {
            
            let event = PFObject(className: "Event")
            event["title"] = eventTitle.text
            event["description"] = eventDescription.text
            event["code"] = randomString
            event["creator"] = PFUser.currentUser()
        
            if let data = UIImageJPEGRepresentation(image, 0.7){
                let file = PFFile(name: "pic.jpg", data: data)
                
                event["picture"] = file
            }
            event.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                println("Object has been saved.")
            }
        }
       

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveButton.hidden = true

        // Do any additional setup after loading the view.
        eventDescription.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
        eventDescription.layer.borderWidth = 1.0
        eventDescription.layer.cornerRadius = 5
        eventDescription.delegate = self
        placeholderLabel = UILabel()
        placeholderLabel.text = "Event Description"
        placeholderLabel.font = UIFont.italicSystemFontOfSize(eventDescription.font.pointSize)
        placeholderLabel.sizeToFit()
        eventDescription.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPointMake(5, eventDescription.font.pointSize / 2)
        placeholderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeholderLabel.hidden = count(eventDescription.text) != 0
    }
    func textViewDidChange(textView: UITextView) {
        placeholderLabel.hidden = count(textView.text) != 0
    }

    @IBAction func pictureSelection(sender: AnyObject) {
        photoTakingHelper =
            PhotoTakingHelper(viewController: self.navigationController!) { (image: UIImage?) in
                self.image = image
                self.eventPicture.setImage(image, forState: .Normal)
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension String {
    
    subscript (i: Int) -> Character {
        return self[advance(self.startIndex, i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        return substringWithRange(Range(start: advance(startIndex, r.startIndex), end: advance(startIndex, r.endIndex)))
    }
}