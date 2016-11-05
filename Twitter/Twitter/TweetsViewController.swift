//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Liang Rui on 10/30/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,TweetCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    var refreshControl : UIRefreshControl!
    var tweets : [Tweet]?
    
    @IBAction func onCompose(_ sender: AnyObject) {
        performSegue(withIdentifier: "ShowCompose", sender: nil)
    }
    @IBAction func onLogout(_ sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
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
        TwitterClient.sharedInstance.homeTimeline(success:
            { (tweets: [Tweet]) in
                print ("Got data")
                self.tweets = tweets
                self.tableView.reloadData()
                
        }) {
            (error: NSError) in
            print ("Error in TweetsVC : \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.tweet = tweets![indexPath.row]
        cell.delegate = self
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        //loadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "ShowCompose") {
            if let destVC = segue.destination as? UINavigationController {
                let comVC = destVC.viewControllers[0] as! ComposeViewController
                comVC.startText = nil
            }
        } else if (segue.identifier == "DetailSegue") {
            print ("DetailSegue")
            let thisTweet = sender as! Tweet
            let detailNavController = segue.destination as! UINavigationController
            let detailViewController = detailNavController.viewControllers[0] as! TweetDetailViewController
            detailViewController.tweet = thisTweet
        }
    }
    
    func tweetCellDelegate(tweetCell: TweetTableViewCell) {
        let indexPath = tableView.indexPath(for: tweetCell)
        performSegue(withIdentifier: "DetailSegue", sender: tweets![(indexPath?.row)!] )
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
