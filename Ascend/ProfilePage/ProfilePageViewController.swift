//
//  ProfilePageViewController.swift
//  Ascend
//
//  Created by Diwash Biswa on 8/1/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class ProfilePageViewController: UIViewController {

    @IBOutlet weak var constraintsForSlideView: NSLayoutConstraint!
    @IBOutlet weak var openButtonLabel: UIButton!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var trailingConstraints: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
    }
    
    //profile button clicked
    @IBAction func slideOutMenuButton(_ sender: Any) {
        //constraintsForSlideView.constant = 0
        trailingConstraints.constant = 0
        
        //openButtonLabel.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations: ({
            self.view.layoutIfNeeded()
        }))
    }
    
    //back button clicked
    @IBAction func backButtonClicked(_ sender: Any) {
        //constraintsForSlideView.constant = 305
        trailingConstraints.constant = 307
        
        UIView.animate(withDuration: 0.5, animations: ({
            self.view.layoutIfNeeded()
        }))
        
        //delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.55, execute: {
            //self.openButtonLabel.isHidden = false
        })
        

    }
    
    
}
