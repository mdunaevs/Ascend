//
//  ViewController.swift
//  Ascend_achievement
//
//  Created by Christian Woldemdhin on 7/19/19.
//  Copyright © 2019 Christian Woldemdhin. All rights reserved.
//

import UIKit
import Charts
import MBCircularProgressBar

class ViewController: UIViewController {
    @IBOutlet var progressView1: MBCircularProgressBarView!
    @IBOutlet var lineChartView: LineChartView!
  
    @IBOutlet var progressView2: MBCircularProgressBarView!
    @IBOutlet var progressView3: MBCircularProgressBarView!
    @IBOutlet var progressView4: MBCircularProgressBarView!
    @IBOutlet var progressView5: MBCircularProgressBarView!
//Coredata import array of achievement
    @IBOutlet weak var staminaButton: UIButton!
    @IBOutlet weak var metresButton: UIButton!
    var task = TaskList.sharedInstance
    
    


//After getting the array of task completed and task still left for each category and them divide the numbers and multiply by 100 to get percentage
//every indeox is co-related with category

    var totalTaskAmountDaily = TaskList.sharedInstance.listOfTasks.count
    override func viewDidLoad() {
        //super.viewDidLoad()
        staminaButton.layer.cornerRadius = 10
        metresButton.layer.cornerRadius = 10
        metresButton.setTitle("Meters: \(getTotalCompletedTask())", for: .normal)
        var progressTrackerPercent = getDataforProgressBar()
        self.progressView1.value = CGFloat(progressTrackerPercent[0])
        self.progressView2.value = CGFloat(progressTrackerPercent[1])
        self.progressView3.value = CGFloat(progressTrackerPercent[2])
        self.progressView4.value = CGFloat(progressTrackerPercent[3])
        self.progressView5.value = CGFloat(progressTrackerPercent[4])
        setChartView()
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
    
    func getDataforProgressBar() -> [Int]{
        print("Academic: \(TaskList.sharedInstance.amtOfAcademicTasks), Social: \(TaskList.sharedInstance.amtOfSocialTasks), Health: \(TaskList.sharedInstance.amtOfHealthTasks), Events: \(TaskList.sharedInstance.amtOfEventsTasks), Other: \(TaskList.sharedInstance.amtOfOtherTasks)")
        var percentageForAcademic, percentageForHealth, percentageForEvents, percentageForSocial, percentageForOther: Int
        
        if getAmtOfCategory(category: .academic) == 0{
            percentageForAcademic = 0
        } else {
            percentageForAcademic = (getAmtCompletedOfCategory(category: .academic) * 100) / getAmtOfCategory(category: .academic)
        }
        
        if getAmtOfCategory(category: .health) == 0{
             percentageForHealth = 0
        } else{
            percentageForHealth = (getAmtCompletedOfCategory(category: .health) * 100) / getAmtOfCategory(category: .health)
        }
        
        if getAmtOfCategory(category: .events) == 0{
             percentageForEvents = 0
        } else {
             percentageForEvents = (getAmtCompletedOfCategory(category: .events) * 100) / getAmtOfCategory(category: .events)
        }
        
        if getAmtOfCategory(category: .social) == 0 {
             percentageForSocial = 0
        } else {
           percentageForSocial = (getAmtCompletedOfCategory(category: .social) * 100) / getAmtOfCategory(category: .social)
        }
        
        if getAmtOfCategory(category: .other) == 0 {
           percentageForOther = 0
        } else {
            percentageForOther = (getAmtCompletedOfCategory(category: .other) * 100) / getAmtOfCategory(category: .other)
        }
        
        let taskArray = [percentageForAcademic, percentageForSocial, percentageForHealth, percentageForEvents, percentageForOther]
        
        return taskArray
    }
    
    func getAmtOfCategory(category: CategoryType) -> Int{
        var totalCategory: Int = 0
        for index in 0..<TaskList.sharedInstance.listOfTasks.count{
            if TaskList.sharedInstance.listOfTasks[index].category == category{
                totalCategory += 1
            }
        }
        return totalCategory
    }
    
    func getAmtCompletedOfCategory(category: CategoryType) -> Int{
        var totalCompletedCategory: Int = 0
        for index in 0..<TaskList.sharedInstance.listOfTasks.count{
            if TaskList.sharedInstance.listOfTasks[index].category == category && TaskList.sharedInstance.listOfTasks[index].completed == true{
                totalCompletedCategory += 1
            }
        }
        return totalCompletedCategory
    }
    
    @IBAction func progressBar1ButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 2){
            self.progressView1.frame = CGRect(x: 150, y: 120, width: 250, height: 250)
        }
        self.progressView2.frame = CGRect(x: 45, y: 225, width: 60, height: 60)
        self.progressView3.frame = CGRect(x: 86, y: 191, width: 60, height: 60)
        self.progressView4.frame = CGRect(x: 125, y: 142, width: 60, height: 60)
        self.progressView5.frame = CGRect(x: 169, y: 96, width: 60, height: 60)
    }
    
    
    @IBAction func progressBar2ButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 2){
            self.progressView2.frame = CGRect(x: 150, y: 120, width: 250, height: 250)
        }
        self.progressView1.frame = CGRect(x: 0, y: 268, width: 60, height: 60)
        self.progressView3.frame = CGRect(x: 86, y: 191, width: 60, height: 60)
        self.progressView4.frame = CGRect(x: 125, y: 142, width: 60, height: 60)
        self.progressView5.frame = CGRect(x: 169, y: 96, width: 60, height: 60)
    }
    
    
    
    @IBAction func progressBar3ButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 2){
            self.progressView3.frame = CGRect(x: 150, y: 120, width: 250, height: 250)
        }
        self.progressView1.frame = CGRect(x: 0, y: 268, width: 60, height: 60)
        self.progressView2.frame = CGRect(x: 45, y: 225, width: 60, height: 60)
        self.progressView4.frame = CGRect(x: 125, y: 142, width: 60, height: 60)
        self.progressView5.frame = CGRect(x: 169, y: 96, width: 60, height: 60)
    }
    
    
    
    @IBAction func progressBar4ButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 2){
            self.progressView4.frame = CGRect(x: 150, y: 120, width: 250, height: 250)
        }
        self.progressView1.frame = CGRect(x: 0, y: 268, width: 60, height: 60)
        self.progressView2.frame = CGRect(x: 45, y: 225, width: 60, height: 60)
        self.progressView3.frame = CGRect(x: 86, y: 191, width: 60, height: 60)
        self.progressView5.frame = CGRect(x: 169, y: 96, width: 60, height: 60)
    }
    
    
    
    @IBAction func progressBar5ButtonPressed(_ sender: Any) {
        UIView.animate(withDuration: 2){
            self.progressView5.frame = CGRect(x: 150, y: 120, width: 250, height: 250)
        }
        self.progressView1.frame = CGRect(x: 0, y: 268, width: 60, height: 60)
        self.progressView2.frame = CGRect(x: 45, y: 225, width: 60, height: 60)
        self.progressView3.frame = CGRect(x: 86, y: 191, width: 60, height: 60)
        self.progressView4.frame = CGRect(x: 125, y: 142, width: 60, height: 60)
    }
    
    @IBAction func repositionProgressBar(_ sender: Any) {
            self.progressView1.frame = CGRect(x: 0, y: 268, width: 60, height: 60)
            self.progressView2.frame = CGRect(x: 45, y: 225, width: 60, height: 60)
            self.progressView3.frame = CGRect(x: 86, y: 191, width: 60, height: 60)
            self.progressView4.frame = CGRect(x: 125, y: 142, width: 60, height: 60)
            self.progressView5.frame = CGRect(x: 169, y: 96, width: 60, height: 60)
        
    }

    func setChartView(_ count : Int = 20){
        
        //        let values = (0..<count).map{(i)->ChartDataEntry in
        
        //            let val = Double(arc4random_uniform(UInt32(count))+3)
        
        //            //print(val)
        
        //            return ChartDataEntry(x: Double(i), y: val)
        
        //        }
        var todaysPercentage: Int
        if totalTaskAmountDaily == 0{
           todaysPercentage = 0
        } else{
           todaysPercentage = (getTotalCompletedTask() * 100) / totalTaskAmountDaily
        }
        //print(getTotalCompletedTask())
        //print("HHH")
        //print(totalTaskAmountDaily)
        let taskPercentageDay1 = [40, 0, 0 , 0 , 0 , 0 , 0]
        let taskPercentageDay2 = [0, 70, 0 , 0 , 0 , 0 , 0]
        let taskPercentageDay3 = [0, 0, 80 , 0 , 0 , 0 , 0]
        let taskPercentageDay4 = [0, 0, 0 , 50 , 0 , 0 , 0]
        let taskPercentageDay5 = [0, 0, 0 , 0 , 35 , 0 , 0]
        let taskPercentageDay6 = [0, 0, 0 , 0 , 0 , 65 , 0]
        var taskPercentageDay7 = [0, 0, 0 , 0 , 0 , 0]
        taskPercentageDay7.append(todaysPercentage)
        
        
        let days = ["Wed", "Thu", "Fri", "Sat", "Sun", "Mon", "Tue"]
        let percent = ["10%", "20%", "30%",  "40%",  "50%", "60%", "70%",  "80%", "90%",  "100%" ]
        
        
        
        let data = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        for i in 0..<taskPercentageDay1.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay1[i]) ))
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "Monday")
        data.addDataSet(line1)
        line1.drawFilledEnabled = true
        line1.fillColor =   #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
        if (taskPercentageDay2.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay2.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay2[i]) ))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Tuesday")
            data.addDataSet(line2)
            line2.drawFilledEnabled = true
            line2.fill = Fill(color:UIColor.green)
            line2.fillColor =  #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
        }
        
        if (taskPercentageDay3.count > 0) {
            var lineChartEntry3 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay3.count {
                lineChartEntry3.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay3[i]) ))
            }
            
            let line3 = LineChartDataSet(entries: lineChartEntry3, label: "Wednesday")
            data.addDataSet(line3)
            line3.drawFilledEnabled = true
            line3.fillColor =  #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
        }
        
        if (taskPercentageDay4.count > 0) {
            var lineChartEntry4 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay4.count {
                lineChartEntry4.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay4[i]) ))
            }
            let line4 = LineChartDataSet(entries: lineChartEntry4, label: "Thursday")
            data.addDataSet(line4)
            line4.drawFilledEnabled = true
            line4.fillColor = #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
            
        }
        
        if (taskPercentageDay5.count > 0) {
            var lineChartEntry5 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay5.count {
                lineChartEntry5.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay5[i]) ))
            }
            let line5 = LineChartDataSet(entries: lineChartEntry5, label: "Friday")
            data.addDataSet(line5)
            line5.drawFilledEnabled = true
            line5.fillColor =  #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
        }
        
        
        
        if (taskPercentageDay6.count > 0) {
            var lineChartEntry6 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay6.count {
                lineChartEntry6.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay6[i]) ))
            }
            let line6 = LineChartDataSet(entries: lineChartEntry6, label: "Saturday")
            data.addDataSet(line6)
            line6.drawFilledEnabled = true
            line6.fillColor =  #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)
            
        }
        
        if (taskPercentageDay7.count > 0) {
            var lineChartEntry7 = [ChartDataEntry]()
            for i in 0..<taskPercentageDay7.count {
                lineChartEntry7.append(ChartDataEntry(x: Double(i), y: Double(taskPercentageDay7[i]) ))
            }
            
            let line7 = LineChartDataSet(entries: lineChartEntry7, label: "Sunday")
            data.addDataSet(line7)
            line7.drawFilledEnabled = true
            line7.fillColor = #colorLiteral(red: 0.4980392157, green: 0.6705882353, blue: 0.8392156863, alpha: 0.9208583048)        }
        
        self.lineChartView.data = data
        
        lineChartView.animate(xAxisDuration: 0.5)
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: days)
        lineChartView.xAxis.granularity = 1
        lineChartView.leftAxis.valueFormatter = IndexAxisValueFormatter(values: percent)
        lineChartView.leftAxis.granularity = 1
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        staminaButton.layer.cornerRadius = 24
        metresButton.layer.cornerRadius = 24
        
    }
//Comment
  
    
    
    
    @IBAction func staminaButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Stamina", message:"This reperesents the number of days you have completed all your tasks." , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            
         alert.dismiss(animated: true, completion: nil)}))
         self.present(alert, animated: true)
    }
    
    @IBAction func metresButton(_ sender: Any) {
        
        let alert = UIAlertController(title: "Meters", message:"This reperesents the number of tasks you have completed today." , preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: { action in
            
        alert.dismiss(animated: true, completion: nil)}))
        self.present(alert, animated: true)
    }
    
    
}

