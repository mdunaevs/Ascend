//
//  ViewController.swift
//  testingCharts
//
//  Created by Max Dunaevschi on 7/16/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit
import Charts




class HomePageViewController: UIViewController, ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        var amtAcademic = 0
        var amtSocial = 0
        var amtHealth = 0
        var amtEvents = 0
        var amtOther = 0
        /*var academicValue = Double(categoryCount[.academic]! * 100) / total
         var socialValue = Double(categoryCount[.social]! * 100) / total
         var healthValue = Double(categoryCount[.health]! * 100) / total
         var eventsValue = Double(categoryCount[.events]! * 100) / total
         var otherValue = Double(categoryCount[.other]! * 100) / total*/
        
        for index in 0..<taskList.listOfTasks.count{
            if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .academic && taskList.listOfTasks[index].pinned == false{
                amtAcademic += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .social && taskList.listOfTasks[index].pinned == false{
                amtSocial += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .health && taskList.listOfTasks[index].pinned == false{
                amtHealth += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .events && taskList.listOfTasks[index].pinned == false{
                amtEvents += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .other && taskList.listOfTasks[index].pinned == false{
                amtOther += 1
            }
        }
        
        let data_val = entry.data as! String
        if data_val == "A"{
            let pop = Popup()
            pop.toplabel.backgroundColor = UIColor(named: "academicUpdate")
            pop.bottomlabel.backgroundColor = UIColor(named: "academicUpdate")
            pop.titleLabel.text = "Academic"
            pop.subtitleLabel .text = "Today \(amtAcademic) of your tasks are Academic!"
            pop.imageIcon.image = UIImage(named: "AcademicIcon")
            self.view.addSubview(pop)
        }
        else if data_val == "H" {
            let pop = Popup()
            pop.toplabel.backgroundColor = UIColor(named: "healthUpdate")
            pop.bottomlabel.backgroundColor = UIColor(named: "healthUpdate")
            pop.titleLabel.text = "Health"
            pop.subtitleLabel .text = "Today \(amtHealth) of your tasks are Health-related!"
            pop.imageIcon.image = UIImage(named: "redheart")
            self.view.addSubview(pop)
        }
        else if data_val == "E" {
            let pop = Popup()
            pop.toplabel.backgroundColor = UIColor(named: "eventsUpdate")
            pop.bottomlabel.backgroundColor = UIColor(named: "eventUpdate")
            pop.titleLabel.text = "Event"
            pop.subtitleLabel .text = "Today \(amtEvents) of your tasks are Events!"
            pop.imageIcon.image = UIImage(named: "calander")
            self.view.addSubview(pop)
        }
        else if data_val == "S" {
            let pop = Popup()
            pop.toplabel.backgroundColor = UIColor(named: "socialUpdate")
            pop.bottomlabel.backgroundColor = UIColor(named: "socialUpdate")
            pop.stack.setCustomSpacing(-90, after: pop.stack.arrangedSubviews[0])
            pop.stack.setCustomSpacing(-120, after: pop.stack.arrangedSubviews[1])
            pop.titleLabel.text = "Social"
            pop.subtitleLabel .text = "Today \(amtSocial) of your tasks involve Social Interaction!"
            pop.imageIcon.image = UIImage(named: "hands")
            self.view.addSubview(pop)
        }
        else {
            let pop = Popup()
            pop.toplabel.backgroundColor = UIColor(named: "otherUpdate")
            pop.bottomlabel.backgroundColor = UIColor(named: "otherUpdate")
            pop.titleLabel.text = "Other"
            pop.subtitleLabel .text = "Today \(amtOther) of your tasks are Miscellaneous!"
            pop.imageIcon.image = UIImage(named: "question")
            self.view.addSubview(pop)
        }
    }

    @IBOutlet weak var pieView: PieChartView!
    
    //var taskList = TaskList(listOfTasks: [])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        TaskList.sharedInstance.buildTaskList()
        //print(TaskList.sharedInstance.rangeOfTasks)
        setupPieChart()
        pieView.delegate = self
        //print("After the build")
        //print(TaskList.sharedInstance.amtOfAcademicTasks)
        //print(TaskList.sharedInstance.amtOfOtherTasks)
        
    }
    
    var taskList = TaskList.sharedInstance

    func calculateCategoryValues() -> [CategoryType:Double]{
        /*var total: Double = Double(taskList.li.count)
        var categoryCount: [CategoryType: Int] = [.academic:0, .social: 0, .health: 0, .events: 0, .other: 0]
        for index in 0..<taskList.count{
            var cat = taskList[index].category
            categoryCount[cat] = categoryCount[cat]! + 1
        }
        //print(categoryCount)*/
        
        var amtAcademic = 0
        var amtSocial = 0
        var amtHealth = 0
        var amtEvents = 0
        var amtOther = 0
        /*var academicValue = Double(categoryCount[.academic]! * 100) / total
        var socialValue = Double(categoryCount[.social]! * 100) / total
        var healthValue = Double(categoryCount[.health]! * 100) / total
        var eventsValue = Double(categoryCount[.events]! * 100) / total
        var otherValue = Double(categoryCount[.other]! * 100) / total*/
        
        for index in 0..<taskList.listOfTasks.count{
            if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .academic && taskList.listOfTasks[index].pinned == false{
                amtAcademic += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .social && taskList.listOfTasks[index].pinned == false{
                amtSocial += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .health && taskList.listOfTasks[index].pinned == false{
                amtHealth += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .events && taskList.listOfTasks[index].pinned == false{
                amtEvents += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .other && taskList.listOfTasks[index].pinned == false{
                amtOther += 1
            }
        }
        let total: Double = Double(amtAcademic + amtSocial + amtHealth + amtEvents + amtOther)
        let academicValue = Double(amtAcademic * 100) / total
        let socialValue = Double(amtSocial * 100) / total
        let healthValue = Double(amtHealth * 100) / total
        let eventsValue = Double(amtEvents * 100) / total
        let otherValue = Double(amtOther * 100) / total
        
        /*let academicValue = Double(taskList.amtOfAcademicTasks * 100) / total
        let socialValue = Double(taskList.amtOfSocialTasks * 100) / total
        let healthValue = Double(taskList.amtOfHealthTasks * 100) / total
        let eventsValue = Double(taskList.amtOfEventsTasks * 100) / total
        let otherValue = Double(taskList.amtOfOtherTasks * 100) / total*/
        let ans: [CategoryType: Double] = [.academic: academicValue, .social: socialValue, .health: healthValue, .events: eventsValue, .other: otherValue]
        //print(ans)
        return ans
    }
    
    func setupPieChart(){
        // No title for the pie chart
        pieView.chartDescription?.enabled = false
        // No hole in the center. You can change size of hole
        pieView.drawHoleEnabled = true
        pieView.holeRadiusPercent = 0.35
        pieView.legend.enabled = false
        pieView.animate(xAxisDuration: 2)
        pieView.rotationAngle = 0
        pieView.rotationEnabled = true
        pieView.isUserInteractionEnabled = true
        
        //print("(\(TaskList.sharedInstance.amtOfAcademicTasks), \(TaskList.sharedInstance.amtOfSocialTasks), \(TaskList.sharedInstance.amtOfHealthTasks), \(TaskList.sharedInstance.amtOfEventsTasks), \(TaskList.sharedInstance.amtOfOtherTasks))")
        
        var entries: [PieChartDataEntry] = Array()
        var categoryValues = calculateCategoryValues()
        var colors : [UIColor] = []
        
        var amtAcademic = 0
        var amtSocial = 0
        var amtHealth = 0
        var amtEvents = 0
        var amtOther = 0
        /*var academicValue = Double(categoryCount[.academic]! * 100) / total
         var socialValue = Double(categoryCount[.social]! * 100) / total
         var healthValue = Double(categoryCount[.health]! * 100) / total
         var eventsValue = Double(categoryCount[.events]! * 100) / total
         var otherValue = Double(categoryCount[.other]! * 100) / total*/
        
        for index in 0..<taskList.listOfTasks.count{
            if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .academic && taskList.listOfTasks[index].pinned == false{
                amtAcademic += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .social && taskList.listOfTasks[index].pinned == false{
                amtSocial += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .health && taskList.listOfTasks[index].pinned == false{
                amtHealth += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .events && taskList.listOfTasks[index].pinned == false{
                amtEvents += 1
            } else if !taskList.listOfTasks[index].completed && taskList.listOfTasks[index].category == .other && taskList.listOfTasks[index].pinned == false{
                amtOther += 1
            }
        }
        
        if TaskList.sharedInstance.rangeOfTasks.contains("A") && amtAcademic > 0{
            entries.append(PieChartDataEntry(value: categoryValues[.academic]!, label: "Academic", data: "A" ))
            colors.append(UIColor(named: "academicUpdate")!)
        }
        if TaskList.sharedInstance.rangeOfTasks.contains("S") && amtSocial > 0 {
            entries.append(PieChartDataEntry(value: categoryValues[.social]!, label: "Social", data: "S" ))
            colors.append(UIColor(named:"socialUpdate")!)
        }
        if TaskList.sharedInstance.rangeOfTasks.contains("H") && amtHealth > 0 {
            entries.append(PieChartDataEntry(value: categoryValues[.health]!, label: "Health", data: "H"))
            colors.append(UIColor(named:"healthUpdate")!)
        }
        if TaskList.sharedInstance.rangeOfTasks.contains("E") && amtEvents > 0{
            entries.append(PieChartDataEntry(value: categoryValues[.events]!, label: "Events", data: "E"))
            colors.append(UIColor(named:"eventsUpdate")!)
        }
        if TaskList.sharedInstance.rangeOfTasks.contains("O") && amtOther > 0 {
            entries.append(PieChartDataEntry(value: categoryValues[.other]!, label: "Other", data: "O"))
            colors.append(UIColor(named:"otherUpdate")!)
        }
        let dataSet = PieChartDataSet(entries: entries, label: "")
        dataSet.entryLabelColor = UIColor.black
        dataSet.colors = colors as! [NSUIColor]
        dataSet.drawValuesEnabled = false

//        if(categoryValues[.academic]! < 7.0 || categoryValues[.social]! < 7.0 || categoryValues[.health]! < 7.0 || categoryValues[.events]! < 7.0 || categoryValues[.other]! < 7.0){
            pieView.legend.enabled = false
            pieView.drawEntryLabelsEnabled = true
//        }
        pieView.data = PieChartData(dataSet: dataSet)
    }
    
    func convertDateToNumber(time: String) -> Double {
        var parsedTime: [String] = time.components(separatedBy: " ")
        var decimal = Double("\(parsedTime[0]).\(parsedTime[2])")!
        if parsedTime[3] == "PM" && parsedTime[0] != "12"{
            decimal += 12.0
        }
        if parsedTime[3] == "AM" && parsedTime[0] == "12"{
            decimal -= 12
        }
        return decimal
    }
    
    func mergeSort(_ array: [Task]) -> [Task] {
        guard array.count > 1 else { return array }
        
        let middleIndex = array.count / 2
        
        let leftArray = mergeSort(Array(array[0..<middleIndex]))
        let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
        
        return merge(leftArray, rightArray)
    }
    
    func merge(_ left: [Task], _ right: [Task]) -> [Task] {
        var leftIndex = 0
        var rightIndex = 0
        
        var orderedArray: [Task] = []
        
        while leftIndex < left.count && rightIndex < right.count {
            let leftElement = convertDateToNumber(time: left[leftIndex].time)
            let rightElement = convertDateToNumber(time: right[rightIndex].time)
            
            if leftElement < rightElement {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else if leftElement > rightElement {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            } else {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        
        return orderedArray
    }
    
    @IBAction func sortLists(_ sender: Any) {
        TaskList.sharedInstance.incompleteTasks = mergeSort(TaskList.sharedInstance.incompleteTasks)
        TaskList.sharedInstance.currentTasks = mergeSort(mergeSort(TaskList.sharedInstance.currentTasks))
    }
    
}

