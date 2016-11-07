//
//  MenuProfileTableViewCell.swift
//  Twitter
//
//  Created by Liang Rui on 11/7/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class MenuProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var screenName: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        profileImg.setImageWith((User.currentUser?.profileUrl)!)
        print ("The user profile url is \((User.currentUser?.profileUrl)!)")
        profileImg.layer.cornerRadius = 3
        profileImg.clipsToBounds = true
        
        name.text = User.currentUser?.name
        screenName.text = User.currentUser?.screenName
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
