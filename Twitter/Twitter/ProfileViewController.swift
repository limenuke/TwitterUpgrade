//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Liang Rui on 11/5/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var thisUser : User?
    var tweets : [Tweet]?
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let attrs = [
            NSForegroundColorAttributeName: UIColor.white,
            ]
        
        let navBar = self.navigationController?.navigationBar
        navBar?.titleTextAttributes = attrs
        navBar?.barTintColor = UIColor.blue
        navBar?.tintColor = UIColor.white
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        let nibName1 = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        tableView.register(nibName1, forCellReuseIdentifier: "ProfileTableViewCell")
        let nibName2 = UINib(nibName: "TweetTableViewCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: "TweetTableViewCell")
        
        loadData()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData () {
        TwitterClient.sharedInstance.userTimeline(id: thisUser!.user_id!, success:
            { (tweets: [Tweet]) in
                print ("Got USER data")
                self.tweets = tweets
                print ("user tweets! \(self.tweets!)")
                for tweet in tweets {
                    print ("tweet text is : \(tweet.text)")
                }
                self.tableView.reloadData()
                
        }) {
            (error: NSError) in
            print ("Error in TweetsVC : \(error.localizedDescription)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tweets != nil) {
            return ((tweets?.count)! + 1)
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.user = thisUser
            cell.selectionStyle = .none
            return cell

        } else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "TweetTableViewCell", for: indexPath) as! TweetTableViewCell
            cell.tweet = tweets![indexPath.row - 1]
            cell.selectionStyle = .none
            return cell
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
