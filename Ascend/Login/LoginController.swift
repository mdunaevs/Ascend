//
//  ViewController.swift
//  Ascend
//
//  Created by Max Dunaevschi on 7/16/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit
import FacebookCore
import FBSDKLoginKit

class LoginController: UIViewController, LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil{
            print("Some error")
        }else if result!.isCancelled{
            print("User cancelled login")
        } else {
            print("User logged in")
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User logged out")
    }
    

    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var loginButton: FBLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        userName.clipsToBounds = true
        userName.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        userName.layer.cornerRadius = 5
        password.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        password.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
        
        //let btnFBLogin = FBLoginButton()
       // btnFBLogin.permissions = ["public_profile", "email", "user_friends"]
       // btnFBLogin.delegate = self
      //  self.view.addSubview(btnFBLogin)
    }
    

}


