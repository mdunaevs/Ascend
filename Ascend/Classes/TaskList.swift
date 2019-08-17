//
//  TaskList.swift
//  testingCharts
//
//  Created by Max Dunaevschi on 7/18/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import Foundation


class TaskList{
    static let sharedInstance: TaskList = TaskList(listOfTasks: [])
    var listOfTasks: [Task] 
    var amtOfAcademicTasks: Int = 0
    var amtOfSocialTasks: Int = 0
    var amtOfHealthTasks: Int = 0
    var amtOfEventsTasks: Int = 0
    var amtOfOtherTasks: Int = 0
    var incompleteTasks: [Task] = []
    var currentTasks: [Task] = []
    var rangeOfTasks = ""
    var alreadyBuilt = false
    
    
    
    init(listOfTasks: [Task]){
        //if TaskList.sharedInstance.listOfTasks.isEmpty{
            //TaskList.sharedInstance.buildTaskList()
        //}
        self.listOfTasks = listOfTasks
        setupTaskCounts()
    }
    func buildTaskList() {
        // Set the file path
        let path = Bundle.main.path(forResource: "taskData", ofType: "txt")
        let filemanager = FileManager.default
        
        if filemanager.fileExists(atPath: path!) && alreadyBuilt == false{
            do{
                let fullText = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
                let readings = fullText.components(separatedBy: "\n") as [String]
                
                for i in 0..<readings.count{
                    if(readings[i] == ""){
                        continue
                    }
                    var taskArray = readings[i].components(separatedBy: "\t")
                    print(taskArray)
                    let taskName = taskArray[0]
                    let taskTime = taskArray[1]
                    //let taskCategory = AutoCat(taskName)
                    let taskCategory = taskArray[2]
                    var task: Task
                    if(taskCategory == "academic"){
                        task = Task(name: taskName, time: taskTime, category: .academic)
                        rangeOfTasks += "A"
                    } else if(taskCategory == "social"){
                        task = Task(name: taskName, time: taskTime, category: .social)
                        rangeOfTasks += "S"
                    } else if(taskCategory == "health"){
                        task = Task(name: taskName, time: taskTime, category: .health)
                        rangeOfTasks += "H"
                    } else if(taskCategory == "events"){
                        task = Task(name: taskName, time: taskTime, category: .events)
                        rangeOfTasks += "E"
                    } else {
                        task = Task(name: taskName, time: taskTime, category: .other)
                        rangeOfTasks += "O"
                    }
                    TaskList.sharedInstance.addTask(task: task)
                    
                }
                TaskList.sharedInstance.addTask(task: Task(name: "English essay", time: "3 : 00 PM", category: .academic, pinned: true))
                TaskList.sharedInstance.addTask(task: Task(name: "Hackathon", time: "5 : 00 PM", category: .social, pinned: true))
                TaskList.sharedInstance.addTask(task: Task(name: "Meet with advisor", time: "7 : 00 PM", category: .events, pinned: true))
                alreadyBuilt = true
                
            } catch let error as NSError{
                print("Error: \(error)")
            }
        }

    }
    // When passed an array with tasks already, this function will properly get the correct amount of counts for each individual task.

   
   func setupTaskCounts(){
        for index in 0..<self.listOfTasks.count{
            let currTask: Task = self.listOfTasks[index]
            checkCategoryType(task: currTask)
        }
    }
    
    // Checks what category a given task is and uodates count
   func checkCategoryType(task: Task){
        if(task.category == .academic){
            self.amtOfAcademicTasks =  self.amtOfAcademicTasks + 1
        }
        if(task.category == .social){
            self.amtOfSocialTasks += 1
        }
        if(task.category == .health){
            self.amtOfHealthTasks += 1
        }
        if(task.category == .events){
            self.amtOfEventsTasks += 1
        }
        if(task.category == .other){
            self.amtOfOtherTasks += 1
        }
    }
    
    // Adds task of task array and updates category counts
    func addTask(task: Task){
        if(taskAlreadyExists(newTask: task)){
            print("Task already on your list")
        } else {
            self.listOfTasks.append(task)
            checkCategoryType(task: task)
        }
        

    }
    
    // Returns whether or not a task is already in the list
    func taskAlreadyExists(newTask: Task) -> Bool{
        for index in 0..<self.listOfTasks.count{
            if(newTask.name == self.listOfTasks[index].name && newTask.category == self.listOfTasks[index].category && newTask.time == self.listOfTasks[index].time){
                return true
            }
        }
        return false
    }
    
    // When the user clicks the complete button, the item should be removed from the list
    func removeTask(task: Task){
        for index in (0..<self.listOfTasks.count).reversed(){
            if(task.name == self.listOfTasks[index].name && task.category == self.listOfTasks[index].category && task.time == self.listOfTasks[index].time){
                self.listOfTasks.remove(at: index)
                if task.category == .academic {
                    amtOfAcademicTasks -= 1
                }
                else if task.category == .health {
                   amtOfHealthTasks -= 1
                }
                else if task.category == .events {
                   amtOfEventsTasks -= 1
                }
                else if task.category == .other {
                   amtOfOtherTasks -= 1
                }
                else {
                  amtOfSocialTasks -= 1
                }
            }
        }
    }
    
    func calculateIncompleteTasks(){
        var incompleteTasks: [Task] = []
        for index in 0..<self.listOfTasks.count{
            let currTask: Task = self.listOfTasks[index]
            if currTask.completed{
                continue
            }
            if(currTask.pinned){
                incompleteTasks.append(currTask)
            }
        }
        self.incompleteTasks = incompleteTasks
    }
    
    func calculateCurrentTasks(){
        var currentTasks: [Task] = []
        for index in 0..<self.listOfTasks.count{
            let currTask: Task = self.listOfTasks[index]
            if currTask.completed{
                continue
            }
            if(!currTask.pinned){
                currentTasks.append(currTask)
            }
        }
        self.currentTasks = currentTasks
    }
    
    
    func findTaskInIncomplete(task: Task) -> Int{
        for index in 0..<self.incompleteTasks.count{
            if self.incompleteTasks[index].name == task.name && self.incompleteTasks[index].time == task.time && self.incompleteTasks[index].category == task.category{
                return index
            }
        }
        return -1
        
    }
    func taskToBeAdded(_ Name_of_task: String, _ Time_of_task: String, _ TaskCat: String) -> Task {
        let taskName = Name_of_task
        let taskTime = Time_of_task
        let taskCategory = TaskCat
        var task: Task
        if(taskCategory == "academic"){
            task = Task(name: taskName, time: taskTime, category: .academic)
            rangeOfTasks += "A"
        } else if(taskCategory == "social"){
            task = Task(name: taskName, time: taskTime, category: .social)
            rangeOfTasks += "S"
        } else if(taskCategory == "health"){
            task = Task(name: taskName, time: taskTime, category: .health)
            rangeOfTasks += "H"
        } else if(taskCategory == "events"){
            task = Task(name: taskName, time: taskTime, category: .events)
            rangeOfTasks += "E"
        } else {
            task = Task(name: taskName, time: taskTime, category: .other)
            rangeOfTasks += "O"
        }
        return task
    }
    
    func findTask(task: Task) -> Int{
        for index in 0..<TaskList.sharedInstance.listOfTasks.count{
            let currTask = TaskList.sharedInstance.listOfTasks[index]
            if(currTask.name == TaskList.sharedInstance.listOfTasks[index].name && currTask.category == TaskList.sharedInstance.listOfTasks[index].category && currTask.time == TaskList.sharedInstance.listOfTasks[index].time){
                return index
            }
        }
        return -1
    }
    
    
    
}
 
