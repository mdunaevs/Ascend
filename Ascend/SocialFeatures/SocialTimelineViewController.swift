//
//  TableViewController.swift
//  Ascend
//
//  Created by Aja Sparks on 7/29/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var postMessages: Array = [(picture: #imageLiteral(resourceName: "max"), name: "Max", activity: "Completed Task: Math Homework", time: "11 : 00 AM"), (picture: #imageLiteral(resourceName: "christi"), name: "Christi", activity: "Upcoming Task: Sociology Final Project", time: "9 : 00 AM"), (picture: #imageLiteral(resourceName: "aja"), name: "Aja", activity: "Upcoming Task: Prep for Bio Exam", time: "8 : 00 AM"), (picture: #imageLiteral(resourceName: "diwash"), name: "Diwash", activity: "Completed Task: ES 15 Coding Assignment", time: "5 : 00 AM"), (picture: #imageLiteral(resourceName: "isabelle"), name: "Isabelle", activity: "Upcoming Task: Calc II PSET", time: "4 : 00 AM"), (picture: #imageLiteral(resourceName: "aja"), name: "Aja", activity: "Upcoming Task: Ethics Essay", time: "1 : 00 AM")]
   
    @IBOutlet weak var topbar: UIView!
    @IBOutlet weak var trailingConstraints: NSLayoutConstraint!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var profileButtonLabel: UIButton!
    
    @IBOutlet weak var metersLabel: UILabel!
    
    @IBOutlet weak var profilePictureView: UIImageView!
    
    @IBOutlet var tableViewSocialTimeline: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewMessages()
        addUpcomingMessages()
        tableView?.contentInset = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
        tableView?.scrollIndicatorInsets = UIEdgeInsets(top: -50, left: 0, bottom: 0, right: 0)
        topbar.topAnchor.constraint(equalTo: topbar.safeAreaLayoutGuide.topAnchor ).isActive=true
        //tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: UIApplication.shared.keyWindow!.safeAreaInsets.bottom, right: 0.0)
        setupSafeArea()
        self.view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        profilePictureView.image = #imageLiteral(resourceName: "diwash")
        profilePictureView.layer.cornerRadius = profilePictureView.frame.width / 2
        
        profileButtonLabel.layer.masksToBounds = true
        profileButtonLabel.layer.cornerRadius = 17.5
        
//        resetTime()
//        tableView?.reloadData()

    }
    
    
    func checkIfPosted(yourName: String, activity: String) -> Bool{
        for index in 0..<self.postMessages.count{
            let currName = self.postMessages[index].name
            let currActivity = self.postMessages[index].activity
            
            if(currName == yourName && currActivity == activity){
                return true
            }
        }
        return false
    }
    
    func resetTime(){
        print("indei")
//        let date = Date()
//        let calender = Calendar.current
//        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
//
//        let hour = components.hour
//        let minute = components.minute
//
//        var realTime : String = "\(hour) : \(minute)"
        
        for index in 0..<self.postMessages.count{
            populateTimeLabel(index: index)
        }
    }
    
    //for testing purposes, hardcoded time
    func addUpcomingMessages(){
        //gets current time
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        let hour = components.hour
        let minute = components.minute
        
        var timeNow : String = "\(hour) : \(minute)"
        
        for index in 0..<TaskList.sharedInstance.listOfTasks.count{
            let currTask = TaskList.sharedInstance.listOfTasks[index]
            if(!checkIfPosted(yourName: "Diwash", activity: currTask.name) && currTask.time == "2 : 00 AM"){
                var arrTime = currTask.time.components(separatedBy: " ")
                var mode = arrTime[3]
                timeNow = timeNow + " " + mode
                self.postMessages.insert((picture: #imageLiteral(resourceName: "diwash"), name: "Diwash", activity: "Upcoming Task: " + currTask.name, time: timeNow), at: 0)
                print(currTask)
            }
        }
    }
    
    func addNewMessages(){
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        
        var hour = components.hour
        var forcedHour = hour!
        var minute = components.minute
        if forcedHour >= 12{
            forcedHour -= 12
        }
        var timeNow : String = "\(forcedHour) : \(minute!)"
        
        for index in 0..<TaskList.sharedInstance.listOfTasks.count{
            let currTask = TaskList.sharedInstance.listOfTasks[index]
            if(currTask.completed == true && !checkIfPosted(yourName: "Diwash", activity: currTask.name) && currTask.category == .academic){
                var arrTime = currTask.time.components(separatedBy: " ")
                var mode = ""
                if hour! >= 12{
                    mode = "PM"
                } else {
                    mode = "AM"
                }
                timeNow = timeNow + " " + mode
                self.postMessages.insert((picture: #imageLiteral(resourceName: "diwash"), name: "Diwash", activity: "Completed Task: " + currTask.name, time: timeNow), at: 0)
                print(currTask)
            }
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postMessages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        
        //disable the view
        cell.popUpView.isHidden = true
        
        cell.profileImage.layer.cornerRadius = 20 // (width / 2)
        cell.profileImage.layer.masksToBounds = true
        
        cell.activityLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.activityLabel.numberOfLines = 2
        
        cell.profileImage.image = postMessages[indexPath.row].picture
        cell.nameLabel.text = postMessages[indexPath.row].name
        cell.activityLabel.text = postMessages[indexPath.row].activity
        
        if (cell.activityLabel.text?.contains("Completed"))! {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.progressIcon.image = #imageLiteral(resourceName: "checkmark")
        } else {
            cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            cell.progressIcon.image = #imageLiteral(resourceName: "upcomingTaskGray")
        }
        
        cell.timeLabel.text = populateTimeLabel(index: indexPath.row)
        
        return cell
    }
    
    func populateTimeLabel(index: Int) -> String {
        var currTaskTime = postMessages[index].time

        var timeDouble : Double = convertDateToNumber(time: currTaskTime)

        //gets current time
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)

        let hour = components.hour
        let minute = components.minute

        var timeNow : Double = Double(hour!) + (Double(minute!) / 100) //10.56

        var timeToBePosted = timeNow - timeDouble

        if (timeToBePosted < 1) {
            var temp = timeToBePosted * 100
            temp.round()
            return "\(Int(temp))m"
        }

        timeToBePosted.round()
        var finalTime = Int(timeToBePosted)

        return "\(finalTime)h"
    }
    
    func convertDateToNumber(time: String) -> Double {
        var parsedTime: [String] = time.components(separatedBy: " ")
        var decimal = Double("\(parsedTime[0]).\(parsedTime[2])")!

        if parsedTime[3] == "PM" && parsedTime[0] != "12"{
            decimal += 12.0
        } else if parsedTime[3] == "AM" && parsedTime[0] == "12"{
            decimal -= 12.0
        }
        return decimal
    }
    
    //Expand the cell (cell contains facebook, messenger, gmail button)
    @objc func mailButtonTapped(button: UIButton) {
        print("button clicked!")
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    func getTotalCompletedTask() -> Int{
        var totalCompleted = 0
        for item in TaskList.sharedInstance.listOfTasks{
            if item.completed == true{
                totalCompleted += 1
            }
        }
        return totalCompleted
    }
    
    // View behind the navigation bar that makes animation transition smooth and no white shows up in the background
    var redView : UIView = {
        let redView = UIView()
        //redView.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        //redView.backgroundColor = UIColor.blue
        redView.backgroundColor = UIColor(red: 91/255, green: 185/255, blue: 235/255, alpha: 1)
        return redView
    }()
    
    // Sets up the menu bar with constraint positioning
    private func setupSafeArea(){
        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
    }
    
    @IBAction func profileButtonClicked(_ sender: Any) {
        //menuView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Userprofile-gradient"))
        menuView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
//        let colorTop = UIColor(cgColor: #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1))
//        let colorBottom = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//
//        let gradient: CAGradientLayer = CAGradientLayer()
//
//        gradient.colors = [colorTop, colorBottom]
//
//        gradient.locations = [0.0, 1.0]
//
//        menuView.backgroundColor = UIColor.clear
//
//        let backgroundLayer = gradient
//        backgroundLayer.frame = menuView.frame
//        menuView.layer.insertSublayer(gradient, at: 0)
        
        trailingConstraints.constant = 0
        
        profileButtonLabel.isHidden = true
        
        UIView.animate(withDuration: 0.5, animations: ({
            self.view.layoutIfNeeded()
        }))
        
        metersLabel.text = "\(getTotalCompletedTask())"
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        
        trailingConstraints.constant = 307
        
        profileButtonLabel.isHidden = false
        
        UIView.animate(withDuration: 0.5, animations: ({
            self.view.layoutIfNeeded()
        }))
        
    }
    
    
    
}
