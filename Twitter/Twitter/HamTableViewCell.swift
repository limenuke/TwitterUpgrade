//
//  HamTableViewCell.swift
//  Twitter
//
//  Created by Liang Rui on 11/6/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class HamTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.darkGray
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
