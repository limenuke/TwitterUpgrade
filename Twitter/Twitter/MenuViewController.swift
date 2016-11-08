//
//  MenuViewController.swift
//  Twitter
//
//  Created by Liang Rui on 11/6/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

 
    @IBOutlet weak var tableView: UITableView!
    var hamburgerViewController: HamburgerViewController!
    var hometimelineVC : UINavigationController!
    var profileVC : UINavigationController!
    var mentionsVC : UINavigationController!
    var viewControllers : [UIViewController]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let nibName1 = UINib(nibName: "HamTableViewCell", bundle: nil)
        tableView.register(nibName1, forCellReuseIdentifier: "HamTableViewCell")
        let nibName2 = UINib(nibName: "MenuProfileTableViewCell", bundle: nil)
        tableView.register(nibName2, forCellReuseIdentifier: "MenuProfileCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        self.tableView.backgroundColor = UIColor.black;
        //self.tableView.backgroundView?.backgroundColor = UIColor.black
    
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        
        hometimelineVC = storyboard.instantiateViewController(withIdentifier: "TweetsNav") as! UINavigationController
        
        profileVC = storyboard.instantiateViewController(withIdentifier: "ProfileNav") as! UINavigationController
        let profileViewVC = profileVC.viewControllers[0] as! ProfileViewController
        profileViewVC.thisUser = User.currentUser
        print ("This user's background is \(User.currentUser?.backgroundUrl)")
        
        mentionsVC = storyboard.instantiateViewController(withIdentifier: "MentionsNav") as! UINavigationController
        
        viewControllers.append(profileVC)
        viewControllers.append(hometimelineVC)
        viewControllers.append(mentionsVC)
        
        hamburgerViewController.contentViewController = hometimelineVC
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MenuProfileCell", for: indexPath) as! MenuProfileTableViewCell
            return cell
        }
        if (indexPath.row == 1) {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HamTableViewCell", for: indexPath) as! HamTableViewCell
            cell.cellLabel.text = "Profile"
            return cell
        } else if (indexPath.row == 2) {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HamTableViewCell", for: indexPath) as! HamTableViewCell
            cell.cellLabel.text = "Timeline"
            return cell
        } else  if (indexPath.row == 3) {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HamTableViewCell", for: indexPath) as! HamTableViewCell
            cell.cellLabel.text = "Mentions"
            return cell
        } else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "HamTableViewCell", for: indexPath) as! HamTableViewCell
            cell.cellLabel.text = ""
            return cell
        }
        

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if (indexPath.row < 4 && indexPath.row > 0) {
            hamburgerViewController.contentViewController = viewControllers[indexPath.row-1]
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
