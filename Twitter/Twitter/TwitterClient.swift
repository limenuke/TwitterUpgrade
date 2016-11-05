//
//  TwitterClient.swift
//  Twitter
//
//  Created by Liang Rui on 10/26/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import BDBOAuth1Manager
import UIKit

let twitterConsumerKey = "03KzAjYeVI68G9kZKXHIoXvSh"
let twitterConsumerSecret = "csKH6yuZnuSBX6dCcIN6SVPjzUIIya9kHg1ToXspGT9HuXn9SG"
let twitterBaseURL = URL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance!
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        let notificationName = NSNotification.Name("UserDidLogout")
        NotificationCenter.default.post(name: notificationName, object: nil)
    }
    
    func login(success: @escaping () -> (), failure: @escaping (NSError) -> () ) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        
        TwitterClient.sharedInstance.fetchRequestToken(withPath: "oauth/request_token", method: "GET", callbackURL: URL(string: "mstwitterdemo://oauth"), scope: nil, success:
        { (requestToken:BDBOAuth1Credential?) -> Void in
            
            if (requestToken != nil) {
                let myToken = requestToken!
                let authURL = URL(string:"https://api.twitter.com/oauth/authorize?oauth_token=\(myToken.token!)")
                UIApplication.shared.open(authURL!, options: [:], completionHandler: {
                (completed: Bool) -> Void in
                    if (completed) {
                        print ("authorization completed")
                    } else {
                        print ("not completeD")
                    }
                })
            }
            
        },
        failure: { (myError: Error?) -> Void in
            self.loginFailure?(myError as! NSError)
            print ("Failed to get request token")
                
        })
    }
    
    func handleOpenUrl(url: URL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        let client = TwitterClient.sharedInstance
        client.fetchAccessToken(withPath: "oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken : BDBOAuth1Credential?) in
            
            print("Got access token.")
            client.requestSerializer.saveAccessToken(accessToken)
            self.currentAccount(success: { (user: User) in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) in
                self.loginFailure?(error)
            })
            
            self.loginSuccess?()
    
        },
        failure: { (error : Error?) in
            print("Failed to receive access token");
            self.loginFailure?(error as! NSError)
        })
    }
    
    func currentAccount(success: @escaping (User) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/account/verify_credentials.json", parameters: nil, success: { (operation, response) in
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            print ("User's name is \(user.name)\n")
            print ("User's screen name is \(user.screenName)\n")
            print ("User's profile pic url is \(user.profileUrl)")
            print ("User's description is \(user.tagLine)\n")
            
            success(user)
    
        },
        failure: { (response, error) in
            print ("Error gettting user.")
            failure(error as NSError)
        })
    }
    
    
    func postTweet(params: NSDictionary?, completion: @escaping (NSError?) -> () ){
        TwitterClient.sharedInstance.post("1.1/statuses/update.json", parameters: params, success: { (error, response) in
                print ("Posted tweet!")
                completion(nil)
            }) { (session, error) in
                print ("Error tweeting \(error.localizedDescription)")
                completion(nil)
            }
    }

    
    
    func favorite(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> () ){
        post("1.1/favorites/create.json?id=\(id)", parameters: params, success:
            { (operation, response) -> Void in
                print("favorite")
                completion(nil)
            }, failure:
            { (operation, error) -> Void in
                print("error favoriting")
                completion(error)
            }
        )}
    
    
    func retweet(id: Int, params: NSDictionary?, completion: @escaping (Error?) -> () ) {
        post("1.1/statuses/retweet/\(id).json", parameters: params, progress:
            { (progress) in
                print ("Retweeting")
            }, success:
            { (session, response) in
                print ("Retweeted successfully")
                completion(nil)
            }) { (session, error) in
                print ("Got an error")
                completion(error)
            }
        }
    
    
    
    
    func homeTimeline(success: @escaping ([Tweet]) -> (), failure: @escaping (NSError) -> ()) {
        get("1.1/statuses/home_timeline.json", parameters: nil, success: { (operation, response) in
            let tweetDictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries: tweetDictionaries)
            for tweet in tweets {
                print("\(tweet.text!)\n")
            }
            success(tweets)
        },
        failure: { (response, error) in
            print ("Error getting home timeline.")
            failure(error as NSError)
        })
    }
}
