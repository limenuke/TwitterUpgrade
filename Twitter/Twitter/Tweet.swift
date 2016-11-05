//
//  Tweet.swift
//  Twitter
//
//  Created by Liang Rui on 10/29/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text : String?
    var timestamp: Date?
    var retweetCount : Int = 0
    var favoritesCount : Int = 0
    var id_str : String?
    var id : Int?
    var isRetweet : Bool?
    var myUser : User?
    
    init(dictionary : NSDictionary) {
        print ("This tweet dictionary is \(dictionary)")
        myUser = User(dictionary: dictionary["user"] as! NSDictionary)
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        id = (dictionary["id"] as? Int) ?? 0
        id_str = dictionary["id_str"] as? String
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0 //    (myUser?.favoritesCt) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString) as Date?
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet]{
        var tweets = [Tweet]()
        for thisDictionary in dictionaries {
            let tweet = Tweet(dictionary: thisDictionary)
            tweets.append(tweet)
        }
        return tweets
    }
}
