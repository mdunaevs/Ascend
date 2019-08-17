//
//  MessageCell.swift
//  Ascend
//
//  Created by Aja Sparks on 7/29/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var activityLabel: UILabel!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    @IBOutlet weak var contentViewView: UIView!
    
    
    @IBOutlet var messButton: UIButton!
    
    @IBOutlet var popUpView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        //change the background picture to same image with heart filled in
        likeButton.setBackgroundImage(#imageLiteral(resourceName: "redheart"), for: UIControl.State.normal)
        
    }
    
    @IBAction func contactButtonPressed(_ sender: Any) {
        self.popUpView.isHidden = false
        self.popUpView.frame.size = CGSize(width: popUpView.frame.width, height: 130)
        //self.popUpView.center =
        self.popUpView.layer.cornerRadius = 20
        self.popUpView.backgroundColor = #colorLiteral(red: 0.4610565901, green: 0.7610229254, blue: 1, alpha: 1)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.popUpView.isHidden = true
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
                //self.present(alert, animated: true, completion: nil)
            }
        }
        self.closeButtonPressed(self)
        print("Facebook button pressed!")
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
                //self.present(alert, animated: true, completion: nil)
            }
        }
        self.closeButtonPressed(self)
        print("Messenger button pressed!")
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
                //self.present(alert, animated: true, completion: nil)
            }
        }
        self.closeButtonPressed(self)
        print("Gmail button pressed")
    }
}
