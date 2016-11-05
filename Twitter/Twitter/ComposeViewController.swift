//
//  ComposeViewController.swift
//  Twitter
//
//  Created by Liang Rui on 10/31/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {
    var startText : String?
    var id_str : String?
    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var chars: UILabel!
    
    
    
    @IBAction func onCancel(_ sender: AnyObject) {
        dismiss(animated: true) { 
            
        }
    }
    func textViewDidChange(_ textView: UITextView) {
        print("Did edit...current chars is \(textField.text?.characters.count)")
        chars.text = String((140 - (textField.text?.characters.count)!))
        chars.sizeToFit()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if (startText != nil) {
            print ("The start text is \(startText) and it should be \(startText!) the id_str is \(id_str!)")
            textField.text = ("\(startText!) ")
        } else {
            textField.text = ""
        }
        profileImg.setImageWith((User.currentUser?.profileUrl)!)
        name.text = User.currentUser?.name
        screenName.text = User.currentUser?.screenName
        chars.text = String((140 - (textField.text?.characters.count)!))
        textField.delegate = self
        textField.becomeFirstResponder()
            // Do any additional setup after loading the view.
    }
    @IBAction func onTweet(_ sender: AnyObject) {
        let params = NSMutableDictionary()
        params["status"] = textField.text!
        if (id_str != nil) {
            params["in_reply_to_status_id"] = id_str!
        }
        print(params)
        TwitterClient.sharedInstance.postTweet(params: params, completion: {(error) -> () in
            self.onCancel(self)
        })

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
