//
//  ViewController.swift
//  Ascend
//
//  Created by Christian Woldemdhin on 7/14/19.
//  Copyright © 2019 Christian Woldemdhin. All rights reserved.
//

import UIKit
import Lottie

class LaunchScreenViewController: UIViewController {
    
    // @IBOutlet var mountainAnimation: AnimationView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //startAnimation()
        // Do any additional setup after loading the view
        /*
         mountainAnimation.animation = Animation.named("152-100-percent.json")
         mountainAnimation.play()
         */
        let mountainAnimationView = AnimationView(name: "152-100-percent")
        mountainAnimationView.frame = CGRect(x:25, y: 100, width:370, height:400)
        mountainAnimationView.contentMode = .scaleAspectFit
        self.view.addSubview(mountainAnimationView)
        mountainAnimationView.play(fromProgress: 0, toProgress: 0.7){ (true) in
            let viewController = UIStoryboard(name: "LoginStoryboard", bundle: nil).instantiateInitialViewController() as! LoginController
            self.present(viewController, animated: false, completion: nil)
        }
        //print("HI!!!!!!")
        
        
       
   /*
    let view:UIViewController = UIStoryboard(name: "BaseStoryboard", bundle: nil).instantiateInitialViewController() as! UIViewController
    UIApplication.shared.keyWindow?.rootViewController = view
    show(view, sender: nil)
    self.present(view, animated: true, completion: nil)
 */
    /*
     
     @IBOutlet weak var mountainAnimationView: AnimationView!
     func startAnimation(){
     mountainAnimationView = AnimationView()
     /*mountainAnimationView.animation = Animation.named("152-100-percent.json")
     */
     let mountainAnimation = Animation.named("152-100-percent.json")
     mountainAnimationView.animation = mountainAnimation
     mountainAnimationView.contentMode = .scaleAspectFit
     mountainAnimationView.play()
     
     //mountainAnimationView.play()
     */
    
    }
}
