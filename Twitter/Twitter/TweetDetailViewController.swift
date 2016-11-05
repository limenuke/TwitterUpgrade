//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Liang Rui on 10/31/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {

    var tweet : Tweet?
    @IBOutlet weak var favesLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetsLabel: UILabel!
    @IBOutlet weak var profilePic: UIImageView!
    
    @IBAction func onBack(_ sender: AnyObject) {
        dismiss(animated: true) {
        }
    }
    
    @IBAction func onReply(_ sender: AnyObject) {
        performSegue(withIdentifier: "ShowComposeReply", sender: String("@\(tweet!.myUser!.screenName!)"))
    }
    
    @IBAction func onFavorite(_ sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(id: (tweet!.id)!, params: nil, completion: {(error) -> () in
            //tweetCell.retweetButton.imageView?.image = UIImage(named: "retweet_on.png")
            if (self.tweet!.favoritesCount) > 0 {
                self.favesLabel.text = "\(self.tweet!.favoritesCount + 1)"
            } else {
                self.favesLabel.text = "1"
            }
        })
    }
    
    @IBAction func onRetweet(_ sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(id: (tweet!.id)!, params: nil, completion: {(error) -> () in
            //tweetCell.retweetButton.imageView?.image = UIImage(named: "retweet_on.png")
            if (self.tweet!.retweetCount) > 0 {
                self.retweetsLabel.text = "\(self.tweet!.retweetCount + 1)"
            } else {
                self.retweetsLabel.text = "1"
            }
        })
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profilePic.setImageWith((tweet!.myUser?.profileUrl)!)
        tweetLabel.text = tweet!.text
        screenNameLabel.text = tweet!.myUser?.screenName
        nameLabel.text = tweet!.myUser?.name
        retweetsLabel.text = String(tweet!.retweetCount)
        favesLabel.text = String(tweet!.favoritesCount)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowComposeReply") {
            if let destVC = segue.destination as? UINavigationController {
                let comVC = destVC.viewControllers[0] as! ComposeViewController
                let startStr = sender as! String
                
                comVC.startText = startStr as String?
                comVC.id_str = tweet!.id_str!
            }
        }
    }
}
