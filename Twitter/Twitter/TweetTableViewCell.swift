//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Liang Rui on 10/30/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

@objc protocol TweetCellDelegate {
    @objc optional func tweetCellDelegate(tweetCell: TweetTableViewCell, segueId: String)
}

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetPic: UIImageView!
    @IBOutlet weak var tweetName: UILabel!
    @IBOutlet weak var tweetScreenname: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var tweetTimeAgo: UILabel!
    @IBOutlet weak var faveCount: UILabel!
    @IBOutlet weak var rtCount: UILabel!
    @IBOutlet weak var rtImg: UIImageView!
    @IBOutlet weak var faveImg: UIImageView!
    weak var delegate : TweetCellDelegate?

    var tweet: Tweet! {
        didSet {
            let thisUser = tweet.myUser!
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.labelTap))
            tweetText.isUserInteractionEnabled = true
            tweetText.addGestureRecognizer(tap)
            
            
            let picTap = UITapGestureRecognizer(target: self, action: #selector(TweetTableViewCell.picTap))
            tweetPic.isUserInteractionEnabled = true
            tweetPic.addGestureRecognizer(picTap)
            tweetPic.layer.cornerRadius = 3.0
            tweetPic.clipsToBounds = true
            tweetPic.setImageWith(thisUser.profileUrl!)
            
            tweetName.text = thisUser.name
            tweetName.sizeToFit()
            tweetScreenname.text = "@\(thisUser.screenName!)"
            tweetScreenname.sizeToFit()
            tweetText.text = tweet.text
            tweetText.sizeToFit()
            
            faveCount.text = String(tweet.favoritesCount)
            faveCount.sizeToFit()
            rtCount.text = String(tweet.retweetCount)
            rtCount.sizeToFit()
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            tweetTimeAgo.text = dateFormatter.string(from: tweet.timestamp!)
            faveImg.image = UIImage(named: "heart")
            rtImg.image = UIImage(named:"rt")
        }
    }
    
    func labelTap () {
        if (self.delegate != nil) {
            self.delegate?.tweetCellDelegate!(tweetCell: self, segueId: String("toDetail"))
        }
    }
    
    func picTap() {
        if (self.delegate != nil) {
            self.delegate?.tweetCellDelegate!(tweetCell: self, segueId: String("toProfile"))    
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
