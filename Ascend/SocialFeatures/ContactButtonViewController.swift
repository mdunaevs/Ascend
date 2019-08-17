//
//  ContactButtonViewController.swift
//  Ascend
//
//  Created by Diwash Biswa on 7/25/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

/*
 Like(heart) and contact(mail) button that exist in each post in social timeline
 */
class ContactButtonViewController: UIViewController {//, UITableViewDelegate, UITableViewDataSource {
    
    //contact button
    @IBOutlet weak var mailButton: UIButton!
    //pop up view
    @IBOutlet var popUpView: UIView!
    //main/super view
    @IBOutlet var mainView: UIView!
    //heart button outlet
    @IBOutlet weak var heartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //when the heart button is clicked, changes color to red
    @IBAction func heartButtonClicked(_ sender: Any) {
        //change the background picture to same image with heart filled in
            //heartButton.setBackgroundImage(nil, for: UIControl.State.normal)
        heartButton.isHidden = true
        //heartButtonFilled.setBackgroundImage(#imageLiteral(resourceName: "redheart"), for: UIControl.State.normal)
    }
    //user clicks the contact to join button
    @IBAction func contactButtonPressed(_ sender: Any) {
        //mainView.alpha = 0.5
        //popUpView.alpha = 1.0
        //mainView.layer.opacity = 0.3

        self.view.addSubview(popUpView)
        popUpView.center = self.view.center
        popUpView.layer.cornerRadius = 10
        popUpView.layer.masksToBounds = true
    }
    
    @IBAction func closePopUpViewPressed(_ sender: Any) {
        popUpView.removeFromSuperview()
    }
    
    //takes the user to facebook when fb button is clicked
    @IBAction func facebookButtonPressed(_ sender: Any) {
        if let appURL = URL(string: "facebook://") {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Facebook"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "\(appName) Error", message: "The app is not found! Please install", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    //takes the user to the messenger when the button is clicked
    @IBAction func messengerButtonPressed(_ sender: Any) {
        if let appURL = URL(string: "messenger://") {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Messenger"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "\(appName) Error", message: "The app is not found! Please install", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        popUpView.removeFromSuperview()
    }
    
    //takes the user to gmail //would it be better to use outlook than email?
    @IBAction func gmailButtonPressed(_ sender: Any) {
        if let appURL = URL(string: "gmail://") {
            let canOpen = UIApplication.shared.canOpenURL(appURL)
            print("\(canOpen)")
            
            let appName = "Gmail"
            let appScheme = "\(appName)://"
            let appSchemeURL = URL(string: appScheme)
            
            if UIApplication.shared.canOpenURL(appSchemeURL! as URL) {
                UIApplication.shared.open(appSchemeURL!, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: "\(appName) Error", message: "The app is not found! Please install", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
        popUpView.removeFromSuperview()
    }

}
