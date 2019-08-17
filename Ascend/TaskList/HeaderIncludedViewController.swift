//
//  HeaderIncludedViewController.swift
//  testingCharts
//
//  Created by Max Dunaevschi on 7/21/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit



//class HeaderIncludedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

//    var tempTask = TaskList(listOfTasks: [
//        Task(name: "Physics HW", time: "9am", category: .academic),
//        Task(name: "Doctor appointment", time: "3pm", category: .health),
//        Task(name: "Math club meeting", time: "6pm", category: .social),
//        Task(name: "Dentist appointment", time: "8pm", category: .health, pinned: true)
//        ])
//
//
//    /*var pinnedTasks:[Task] = tempTask.calculatePinnedTasks()
//    var currentTasks:[Task]  = tempTask.calculateCurrentTasks()*/
//
//    @IBOutlet weak var tasklistTable: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        tasklistTable.tableFooterView = UIView(frame: .zero)
//        // Do any additional setup after loading the view.
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        var pinnedTasks:[Task] = tempTask.ca()
//        var currentTasks:[Task]  = tempTask.calculateCurrentTasks()
//        if section == 0{
//            return pinnedTasks.count
//        }
//        return currentTasks.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tasklistTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewHeaderIncludedCell
//        var pinnedTasks:[Task] = tempTask.calculatePinnedTasks()
//        var currentTasks:[Task] = tempTask.calculateCurrentTasks()
//        cell.backgroundColor = UIColor(named: determineBackgroundColor(task: tempTask.listOfTasks[indexPath.row]))
//
//        let taskName = indexPath.section == 0 ? pinnedTasks[indexPath.row].name : currentTasks[indexPath.row].name
//
//        cell.cellLabel?.text = taskName
//
//        if let btnFinished = cell.contentView.viewWithTag(102) as? UIButton {
//            btnFinished.addTarget(self, action: #selector(deleteRow(_:)), for: .touchUpInside)
//        }
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 34
//    }
//
//
//   @objc func deleteRow(_ sender: UIButton){
//        let point = sender.convert(CGPoint.zero, to: tasklistTable)
//        guard let indexPath = tasklistTable.indexPathForRow(at: point) else {
//            return
//        }
//        tempTask.listOfTasks.remove(at: indexPath.row)
//        tasklistTable.deleteRows(at: [indexPath], with: .left)
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let button = UIButton(type: .system)
//        button.setTitle("Edit", for: .normal)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .orange
//        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
//        button.addTarget(self, action: #selector(handleEdit), for: .touchUpInside)
//
//
//        return button
////        let label = UILabel()
////        label.text = "Header"
////        label.backgroundColor = UIColor.lightGray
////        return label
//    }
//
//    @objc func handleEdit(){
//        print("Trying to edit")
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//
//    func determineBackgroundColor(task: Task) -> String{
//        if(task.category == .academic){
//            return "academicColor"
//        } else if(task.category == .social){
//            return "socialColor"
//        }else if(task.category == .health){
//            return "healthColor"
//        }else if(task.category == .events){
//            return "eventsColor"
//        }
//        return "otherColor"
//    }


