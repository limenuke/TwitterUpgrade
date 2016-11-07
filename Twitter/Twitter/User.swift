//
//  User.swift
//  Twitter
//
//  Created by Liang Rui on 10/29/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class User: NSObject {
    var name : String?
    var profileUrl : URL?
    var tagLine : String?
    var screenName : String?
    var dictionary : NSDictionary?
    var favoritesCt : Int?
    var followersCt : Int?
    var followingCt : Int?
    var backgroundUrl : URL?
    var tweetCt : Int?
    var user_id : Int?
    init(dictionary :  NSDictionary) {
        self.dictionary = dictionary
        print ("The user dictionary looks like this \(dictionary)")
        name = dictionary["name"] as? String
        user_id = dictionary["id"] as? Int
        followersCt = dictionary["followers_count"] as? Int
        favoritesCt = dictionary["favourites_count"] as? Int
        followingCt = dictionary["friends_count"] as? Int
        screenName = dictionary["screen_name"] as? String
        tagLine = dictionary["description"] as? String
        let backgroundUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundUrlString = backgroundUrlString {
            backgroundUrl = URL(string: backgroundUrlString)
        }
        
        tweetCt = dictionary["statuses_count"] as? Int
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            let newUrl = profileUrlString.replacingOccurrences(of: "_normal", with: "")
            profileUrl = URL(string: newUrl)
            //print ("Profile url string: \(profileUrlString)")
        }
        
    }
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                
                let userData = defaults.data(forKey: "currentUserData")
                
                if let userData = userData {
                    let dictionary = try! JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set (user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.removeObject(forKey: "currentUserData")
            }
            defaults.synchronize()
        }
    }
    
}
