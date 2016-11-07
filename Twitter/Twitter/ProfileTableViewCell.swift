//
//  ProfileTableViewCell.swift
//  Twitter
//
//  Created by Liang Rui on 11/5/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var flwersNum: UILabel!
    @IBOutlet weak var flwingNum: UILabel!
    @IBOutlet weak var twtNum: UILabel!
    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var v1: UIView!
    @IBOutlet weak var v2: UIView!
    @IBOutlet weak var v3: UIView!
    
    var user: User! {
        didSet {
            if (user.backgroundUrl != nil) {
                backgroundImg.setImageWith(user.backgroundUrl!)
            }
            if (user.profileUrl != nil) {
                profileImg.setImageWith(user.profileUrl!)
                profileImg.layer.cornerRadius = 3.0
                profileImg.clipsToBounds = true
            }
            
            name.text = user.name
            screenName.text = "@\(user.screenName!)"
            flwersNum.text = String(user.followersCt!)
            flwingNum.text = String(user.followingCt!)
            twtNum.text = String(user.tweetCt!)
            flwersNum.text = NumberFormatter.localizedString(from: NSNumber(value: user.followersCt!) , number: NumberFormatter.Style.decimal)
            flwingNum.text = NumberFormatter.localizedString(from: NSNumber(value: user.followingCt!) , number: NumberFormatter.Style.decimal)
            twtNum.text = NumberFormatter.localizedString(from: NSNumber(value: user.tweetCt!) , number: NumberFormatter.Style.decimal)
        
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        v1.layer.borderColor = UIColor.lightGray.cgColor
        v2.layer.borderColor = UIColor.lightGray.cgColor
        v3.layer.borderColor = UIColor.lightGray.cgColor
            
        v1.layer.borderWidth = 1.0;
        v2.layer.borderWidth = 1.0;
        v3.layer.borderWidth = 1.0;
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
