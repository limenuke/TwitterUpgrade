//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Liang Rui on 11/6/16.
//  Copyright © 2016 Etcetera. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBAction func onBack(_ sender: AnyObject) {
        dismiss(animated: true) {
        }
    }
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    var originalLeftMargin: CGFloat!
    
    var contentViewController : UIViewController! {
        didSet(oldContentViewController) {
            view.layoutIfNeeded()   // kicks lazy load to instantiate stuff
            
            if oldContentViewController != nil {
                oldContentViewController.willMove(toParentViewController: nil)
                oldContentViewController.view.removeFromSuperview()
                oldContentViewController.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.contentLeftMargin.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    var menuViewController : UIViewController! {
        didSet(oldMenuViewController) {
            view.layoutIfNeeded()   // kicks lazy load to instantiate stuff
            
            if oldMenuViewController != nil {
                oldMenuViewController.willMove(toParentViewController: nil)
                oldMenuViewController.view.removeFromSuperview()
                oldMenuViewController.didMove(toParentViewController: nil)
            }
            
            menuViewController.willMove(toParentViewController: self)
            menuView.addSubview(menuViewController.view)
            menuViewController.didMove(toParentViewController: self)
        }
    }
    
    @IBAction func onPanGesture(_ sender: AnyObject) {
        let panGR = sender as! UIPanGestureRecognizer
        let translation = panGR.translation(in: view)
        let velocity = panGR.velocity(in: view)
        if panGR.state == .began {
            originalLeftMargin = contentLeftMargin.constant
        } else if panGR.state == .changed {
            contentLeftMargin.constant = originalLeftMargin + translation.x
        } else if panGR.state == .ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.contentLeftMargin.constant = self.view.frame.size.width - 50
                } else {
                    self.contentLeftMargin.constant = 0
                }
                self.view.layoutIfNeeded()
            })
            
            //
        }
    }
    @IBOutlet weak var contentLeftMargin: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
