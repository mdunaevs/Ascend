//
//  AddTaskViewController.swift
//  testingCharts
//
//  Created by Max Dunaevschi on 7/18/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    let datePicker = UIDatePicker()
    let cats = [" ", "Academic", "Social", "Events", "Health", "Other"]
    var selectedCat: String?

    @IBOutlet weak var formScreen: UIView!
    @IBOutlet weak var warningTaskTime: UILabel!
    @IBOutlet weak var warningTaskName: UILabel!
    @IBOutlet weak var AddFormScreen: UIView!
    @IBOutlet weak var taskNameTextField: UITextField!
    
    @IBOutlet weak var TimeTextField: UITextField!
    
    @IBOutlet weak var CategoryTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientLayer()
        createCatPicker()
        createToolbar()
        createTimePicker()
        //AddFormScreen.backgroundColor = UIColor(patternImage: UIImage(named: "cool_background.png")!)
        warningTaskName.text = ""
        warningTaskTime.text = ""
        formScreen.layer.cornerRadius = 24
        
    }
    
    func createGradientLayer() {
        var gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = AddFormScreen.bounds
        
        gradientLayer.colors = [UIColor(named: "Colorforadd1")?.cgColor, UIColor(named: "Colorforadd2")?.cgColor]
        
        AddFormScreen.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    func createTimePicker() {
        datePicker.datePickerMode = .time
        TimeTextField.inputView = datePicker
        let timetoolbar = UIToolbar()
        timetoolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClicked))
        timetoolbar.setItems([doneButton], animated: false)
        timetoolbar.isUserInteractionEnabled = true
        TimeTextField.inputAccessoryView = timetoolbar
    }
    @objc func doneClicked() {
        let dateFormatter = DateFormatter()
        //Now we specify the display format, e.g. "27-08-2015
        dateFormatter.dateFormat = "h : mm a"
        let tasktime = dateFormatter.string(from: datePicker.date)
        //Finally we set the text of the label to our new string with the date
        TimeTextField.text = tasktime
        self.view.endEditing(true)
    }
    func createCatPicker() {
        let catPicker = UIPickerView()
        catPicker.delegate = self
        catPicker.isUserInteractionEnabled = true
        CategoryTextField.inputView = catPicker
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cats.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cats[row]
    }
    @objc func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCat = cats[row]
        CategoryTextField.text = selectedCat
    }
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPicker))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        CategoryTextField.inputAccessoryView = toolBar
    }
    
    @objc func dismissPicker() {
        CategoryTextField.text = selectedCat
        self.view.endEditing(true)
    }
    
//    @objc func dateChanged(datePicker: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        //Now we specify the display format, e.g. "27-08-2015
//        dateFormatter.dateFormat = "hh : mm a"
//        //Now we get the date from the UIDatePicker and convert it to a string
//         let tasktime = dateFormatter.string(from: datePicker.date)
//        //Finally we set the text of the label to our new string with the date
//        TimeTextField.text = tasktime
//    }
    
    

        
    @IBAction func addTaskAndDismiss(_ sender: Any) {
        print(TaskList.sharedInstance.rangeOfTasks)
        if taskNameTextField.text == "" {
            warningTaskName.text = "Please enter a task above"
            warningTaskName.textColor = UIColor.red
        }
        if TimeTextField.text == "" {
            warningTaskTime.text = "Please enter a time for your task"
            warningTaskTime.textColor = UIColor.red
        }
        if let taskName = taskNameTextField.text {
            if taskName != "" {
            if let taskTime = TimeTextField.text {
                if taskTime != "" {
                var task : Task
                if let taskCategory = CategoryTextField.text{
                    if taskCategory == ""{
                        task = TaskList.sharedInstance.taskToBeAdded(taskName, taskTime, AutoCat(taskName))
                    }else {
                        task = TaskList.sharedInstance.taskToBeAdded(taskName, taskTime, taskCategory.lowercased())
                    }
                } else {
                    task = TaskList.sharedInstance.taskToBeAdded(taskName, taskTime, AutoCat(taskName))
                }
                TaskList.sharedInstance.addTask(task: task)
                print(TaskList.sharedInstance.rangeOfTasks)
                print("jier")
                print(TaskList.sharedInstance.listOfTasks)
//                let vc = AddedViewController() as UIViewController
//                let pops = Popup()
//                vc.view.addSubview(pops)
//                self.present
                    if task.category == .academic {
                    let viewController = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
                      let alert = UIAlertController(title: "Task has been added!", message: "\n\n\n\nYou just added an academic task to your list.", preferredStyle: .alert)
                        let iconImageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
                        let iconImage = UIImage(named:"AcademicIcon")
                        iconImageView.image = iconImage
                        alert.view.addSubview(iconImageView)
                    alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                        self.present(viewController!, animated: false, completion: nil)
                    }))
                    
                    self.present(alert, animated: true)
                    }
                    else if task.category == .events {
                        let viewController = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "Task has been added!", message: "\n\n\n\nYou just added an event to your list.", preferredStyle: .alert)
                        let iconImageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
                        let iconImage = UIImage(named:"calander")
                        iconImageView.image = iconImage
                        alert.view.addSubview(iconImageView)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                            self.present(viewController!, animated: false, completion: nil)
                        }))
                        
                        self.present(alert, animated: true)
                    }
                    else if task.category == .health {
                        let viewController = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "Task has been added!", message: "\n\n\n\nYou just added a health-related task to your list.", preferredStyle: .alert)
                        let iconImageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
                        let iconImage = UIImage(named:"redheart")
                        iconImageView.image = iconImage
                        alert.view.addSubview(iconImageView)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                            self.present(viewController!, animated: false, completion: nil)
                        }))
                        
                        self.present(alert, animated: true)
                    }
                    else if task.category == .social {
                        let viewController = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "Task has been added!", message: "\n\n\n\nYou just added a social task to your list.", preferredStyle: .alert)
                        let iconImageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
                        let iconImage = UIImage(named:"hands")
                        iconImageView.image = iconImage
                        alert.view.addSubview(iconImageView)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                            self.present(viewController!, animated: false, completion: nil)
                        }))
                        
                        self.present(alert, animated: true)
                    }
                    else {
                        let viewController = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
                        let alert = UIAlertController(title: "Task has been added!", message: "\n\n\n\nYou just added an event to your list.", preferredStyle: .alert)
                        let iconImageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
                        let iconImage = UIImage(named:"question")
                        iconImageView.image = iconImage
                        alert.view.addSubview(iconImageView)
                        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
                            self.present(viewController!, animated: false, completion: nil)
                        }))
                        
                        self.present(alert, animated: true)
                    }
            }
                }
        }
        }
    }
    
    @IBAction func LeaveScreen(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
        // Do any additional setup after loading the view.
    @IBAction func LeaveScreen2(_ sender: Any) {
         dismiss(animated: true, completion: nil)
    }
    
    }

    // This function is called before the segue to the second controller
    // we can use this to set data fields on the destination controller
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // get a reference to the SECOND view controller
//        if  let homePageViewController = segue.destination as? HomePageViewController,
//            let taskNameToSend = taskNameTextField.text,
//        let taskTimeToSend = taskTimeTextField.text{
//            // set a variable in the SECOND view controller with the String to pass
//            homePageViewController.receivedString = taskNameToSend
//             homePageViewController.receivedString2 = taskTimeToSend
//        }
//    }



    
//func addTaskandDismiss(_ sender: Any) {
//        if let taskname = taskNameTextField.text {
//            // First we need to create a new instance of the NSDateFormatter
//            let dateFormatter = DateFormatter()
//            // Now we specify the display format, e.g. "27-08-2015
//           dateFormatter.dateFormat = "hh : mm"
//            // Now we get the date from the UIDatePicker and convert it to a string
//            let tasktime = dateFormatter.string(from: timepicker.date)
//            // Finally we set the text of the label to our new string with the date
//                var task = TaskList.sharedInstance.taskToBeAdded(taskname, tasktime)
//                TaskList.sharedInstance.addTask(task: task)
//        }
////        var label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
////        label.center = CGPoint(x: 160, y: 284)
////        label.textAlignment = NSTextAlignment.Center
////        label.text = "I'm a test label"
////        self.view.addSubview(label)
//        let viewController = UIStoryboard(name: "HomepageStoryboard", bundle: nil).instantiateInitialViewController()
//
//        self.present(viewController!, animated: false, completion: nil)
//
//    }



//        dismiss(animated: true, completion: nil)
