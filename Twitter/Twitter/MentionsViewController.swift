//
//  MentionsViewController.swift
//  Twitter
//
//  Created by Liang Rui on 11/7/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class MentionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TweetCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    var refreshControl : UIRefreshControl!
    var tweets : [Tweet]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            ]
        
        let navBar = self.navigationController?.navigationBar
        navBar?.titleTextAttributes = attrs
        navBar?.barTintColor = UIColor.blue
        navBar?.tintColor = UIColor.white
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(TweetsViewController.refresher), for: UIControlEvents.valueChanged)
        
        tableView.insertSubview(refreshControl, at: 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        let nibName = UINib(nibName: "TweetTableViewCell", bundle: nil)
        tableView.register(nibName, forCellReuseIdentifier: "TweetTableViewCell")
        
        loadData()
        
        // Do any additional setup after loading the view.
    }
    
    func refresher() {
        print ("Did a refresher!")
        loadData()
        if self.refreshControl.isRefreshing {
            self.refreshControl.endRefreshing()
        }
    }
    
    func loadData () {
        TwitterClient.sharedInstance.mentionsTimeline(success:
            { (tweets: [Tweet]) in
                print ("Got data")
                self.tweets = tweets
                self.tableView.reloadData()
                
        }) {
            (error: NSError) in
            print ("Error in TweetsVC : \(error.localizedDescription)")
        }
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tweets != nil {
            return tweets!.count
        } else {
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell  = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
        cell.selectionStyle = .none
        cell.tweet = tweets![indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "MShowCompose") {
            if let destVC = segue.destination as? ComposeViewController {
                //let comVC =  destVC.viewControllers[0] as! ComposeViewController
                destVC.startText = nil
            }
        } else if (segue.identifier == "MShowDetailSegue") {
            print ("ShowDetailSegue")
            let thisTweet = sender as! Tweet
            //let detailNavController = segue.destination as! UINavigationController
            let detailViewController = segue.destination as! TweetDetailViewController
            // detailNavController.viewControllers[0] as! TweetDetailViewController
            detailViewController.tweet = thisTweet
        } else if (segue.identifier == "MShowProfileSegue") {
            print ("ShowProfileSegue")
            let thisTweet = sender as! Tweet
            //let profileNavController = segue.destination as! UINavigationController
            let thisProfileViewController = segue.destination as! ProfileViewController
            //profileNavController.viewControllers[0] as! ProfileViewController
            thisProfileViewController.thisUser = thisTweet.myUser
        }
    }
    
    func tweetCellDelegate(tweetCell: TweetTableViewCell, segueId: String) {
        let indexPath = tableView.indexPath(for: tweetCell)
        if (segueId == "toDetail") {
            performSegue(withIdentifier: "MShowDetailSegue", sender: tweets![(indexPath?.row)!] )
        } else if (segueId == "toProfile") {
            performSegue(withIdentifier: "MShowProfileSegue", sender:  tweets![(indexPath?.row)!])
        }
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
