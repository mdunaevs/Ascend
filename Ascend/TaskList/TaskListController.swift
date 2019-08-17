//
//  ViewController.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit
import Lottie

class TaskListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    let cellId = "cellId"
    let headerId = "headerId"
    
    
    let backgroundImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "8-1")
        return img
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Calculates the information for the which tasks belong in the sections of the task lists
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        
        //collectionView?.backgroundView = backgroundImage

        setupMenuBar()
        
        
        // Registers custom classes for the headers and cells of the task list
        collectionView?.register(TaskCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 0)
        
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
    }
    
    @objc func segueToHomeScreen(_ sender: UIButton){
        let controller = UIStoryboard(name: "TabBarStoryboard", bundle: nil).instantiateInitialViewController()
        present(controller!, animated: true, completion: nil)
    }
    
    // Instance of the custom menu bar
    var menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    var topSection:TopSection = {
        let top = TopSection()
        return top
    }()
    
    // View behind the navigation bar that makes animation transition smooth and no white shows up in the background
    var redView : UIView = {
        let redView = UIView()
        redView.backgroundColor = UIColor(named: "navbarColor")
        return redView
    }()
    
    // Sets up the menu bar with constraint positioning
    private func setupMenuBar(){

        view.addSubview(redView)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(topSection)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: topSection)
        view.addConstraintsWithFormat(format: "V:[v0(110)]", views: topSection)
        topSection.overviewButton.addTarget(self, action: #selector(segueToHomeScreen(_:)), for: .touchUpInside)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|-110-[v0(50)]", views: menuBar)

        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        menuBar.editButton.addTarget(self, action: #selector(clickedEditButton(_:)), for: .touchUpInside)
        menuBar.pencilButton.addTarget(self, action: #selector(clickedEditButton(_:)), for: .touchUpInside)
    }
    
    var clickedAmt = 0
    
    @objc func clickedEditButton(_ sender: UIButton){
        clickedAmt += 1
        print(clickedAmt)
        
        if clickedAmt % 2 == 0{
            //menuBar.editButton.setTitle("Done", for: .normal)
            menuBar.showPencil()
            menuBar.hideFinish()
            
            collectionView?.reloadData()
            
        } else {
            //menuBar.editButton.setTitle("Edit", for: .normal)
            menuBar.showFinish()
            menuBar.hidePencil()
            collectionView?.reloadData()
        }
    }
    

    // No line spacing between the sections of the navigation bar
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Number of headers
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // Establishes custom view for the header 
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! HeaderView
        let headerTitle = indexPath.section == 0 ? "Incomplete" : "Current"
        header.headerSectionLabel.text = headerTitle
        return header
    }
    
    // Sets the height of the header section to 70 pixels
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
    
    // Determines how many cells per section
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (section == 0){
            return TaskList.sharedInstance.incompleteTasks.count
        }
        return TaskList.sharedInstance.currentTasks.count
    }
    
    
    // Amount of section that will appear in the collection view
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    // Sets the height of the cell in pixels
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

    
    // Establishes custom view for the cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! TaskCell
        
        
        
        
        // Sets information for task name
        let taskName = indexPath.section == 0 ? TaskList.sharedInstance.incompleteTasks[indexPath.row].name : TaskList.sharedInstance.currentTasks[indexPath.row].name
        cell.setTaskName(taskName: taskName)

        // Sets information for task time
        let taskTime = indexPath.section == 0 ? TaskList.sharedInstance.incompleteTasks[indexPath.row].time : TaskList.sharedInstance.currentTasks[indexPath.row].time
        cell.setTaskTime(taskTime: taskTime)
        

        // Sets information for the task category
        let taskCat = indexPath.section == 0 ? TaskList.sharedInstance.incompleteTasks[indexPath.row].category : TaskList.sharedInstance.currentTasks[indexPath.row].category
        if taskCat == .academic{
            cell.setEmojiImage(imageName: "AcademicIcon")
            //cell.setTaskInfoBackground(categoryColor: "academicUpdate")
            //cell.cellView.backgroundColor = UIColor(named: "academicUpdate")?.withAlphaComponent(0.8)
            cell.setTaskInfoBackground(categoryColor: "academicDesigner")
            cell.cellView.backgroundColor = UIColor(named: "academicDesigner")?.withAlphaComponent(0.22)
            cell.cellView.layer.borderColor = UIColor(named: "academicDesigner")?.cgColor
        } else if taskCat == .social{
            cell.setEmojiImage(imageName: "hands")
            //cell.setTaskInfoBackground(categoryColor: "socialUpdate")
            //cell.backgroundColor
            //cell.cellView.backgroundColor = UIColor(named: "socialUpdate")?.withAlphaComponent(0.8)
            cell.setTaskInfoBackground(categoryColor: "socialDesigner")
            cell.cellView.backgroundColor = UIColor(named: "socialDesigner")?.withAlphaComponent(0.15)
            cell.cellView.layer.borderColor = UIColor(named: "socialDesigner")?.cgColor
        } else if taskCat == .health{
            cell.setEmojiImage(imageName: "redheart")
            //cell.setTaskInfoBackground(categoryColor: "healthUpdate")
            //cell.backgroundColor =
            //cell.cellView.backgroundColor = UIColor(named: "healthUpdate")?.withAlphaComponent(0.8)
            cell.setTaskInfoBackground(categoryColor: "healthDesigner")
            cell.cellView.backgroundColor = UIColor(named: "healthDesigner")?.withAlphaComponent(0.19)
            cell.cellView.layer.borderColor = UIColor(named: "healthDesigner")?.cgColor
        } else if taskCat == .events{
            cell.setEmojiImage(imageName: "calander")
            //cell.setTaskInfoBackground(categoryColor: "eventsUpdate")
            //cell.backgroundColor =
            //cell.cellView.backgroundColor = UIColor(named: "eventsUpdate")?.withAlphaComponent(0.8)
            cell.setTaskInfoBackground(categoryColor: "eventsDesigner")
            cell.cellView.backgroundColor = UIColor(named: "eventsDesigner")?.withAlphaComponent(0.25)
            cell.cellView.layer.borderColor = UIColor(named: "eventsDesigner")?.cgColor
        } else {
            cell.setEmojiImage(imageName: "question")
            //cell.setTaskInfoBackground(categoryColor: "otherUpdate")
            //cell.backgroundColor =
            //cell.cellView.backgroundColor = UIColor(named: "otherUpdate")?.withAlphaComponent(0.8)
            cell.setTaskInfoBackground(categoryColor: "otherDesigner")
            cell.cellView.backgroundColor = UIColor(named: "otherDesigner")?.withAlphaComponent(0.22)
            cell.cellView.layer.borderColor = UIColor(named: "otherDesigner")?.cgColor
            
        }
        
        if clickedAmt % 2 == 0{
            if indexPath.section == 0 {
                cell.hideFinish()
                cell.hideRemove()
                cell.showAdd()
                cell.addToCurrentDayButton.addTarget(self, action: #selector(moveTask(_:)), for: .touchUpInside)
            } else {
                cell.hideAdd()
                cell.hideRemove()
                cell.showFinish()
                cell.finishFromCurrentDayButton.addTarget(self, action: #selector(finishTask(_:)), for: .touchUpInside)
            }
        } else {
            if indexPath.section == 0{
                cell.hideAdd()
                cell.hideFinish()
                cell.showRemove()
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(removeTaskFromIncomplete(_:)), for: .touchUpInside)
            } else {
                cell.hideAdd()
                cell.hideFinish()
                cell.showRemove()
                cell.removeFromCurrentDayButton.addTarget(self, action: #selector(removeTaskFromCurrent(_:)), for: .touchUpInside)
            }
        }
        
        return cell
    }
    
    let borderView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 175
        //view.backgroundColor = UIColor.green
        return view
    }()
    
    let animationBackgroundView:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 150
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let congratsAnimation : AnimationView = {
        let view = AnimationView(name: "3091-process-complete")
        //view.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        view.layer.masksToBounds = true
        return view
    }()
    
    let congratsLabel:UILabel = {
        let label = UILabel()
        label.text = "Congratulations!"
        label.font = UIFont.systemFont(ofSize: 28)
        return label
    }()
    
    let blurryBackground: UIView = {
        let view = UIView()
        return view
    }()
    
    
    func showAnimation(category: CategoryType){
        if category == .academic{
            borderView.backgroundColor = UIColor(named: "academicUpdate")
        } else if category == .social{
            borderView.backgroundColor = UIColor(named: "socialUpdate")
        } else if category == .health{
            borderView.backgroundColor = UIColor(named: "healthUpdate")
        } else if category == .events{
            borderView.backgroundColor = UIColor(named: "eventsUpdate")
        } else {
            borderView.backgroundColor = UIColor(named: "otherUpdate")
        }

        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        view.addSubview(borderView)
        view.addConstraintsWithFormat(format: "H:|-30-[v0(350)]", views: borderView)
        view.addConstraintsWithFormat(format: "V:|-280-[v0(350)]", views: borderView)
        
        borderView.addSubview(animationBackgroundView)
        animationBackgroundView.addSubview(congratsAnimation)
        
        borderView.addConstraintsWithFormat(format: "H:|-25-[v0(300)]", views: animationBackgroundView)
        borderView.addConstraintsWithFormat(format: "V:|-25-[v0(300)]", views: animationBackgroundView)
        
        animationBackgroundView.addConstraintsWithFormat(format: "H:|[v0]|", views: congratsAnimation)
        animationBackgroundView.addConstraintsWithFormat(format: "V:|[v0]|", views: congratsAnimation)
        
        animationBackgroundView.addConstraintsWithFormat(format: "V:|[v0]|", views: congratsAnimation)
        
        congratsAnimation.play(fromProgress: 0.27, toProgress: 0.6) { (true) in
            let viewController = UIStoryboard(name: "TasklistStoryboard", bundle: nil).instantiateInitialViewController() as! TaskListController
            self.present(viewController, animated: false, completion: nil)
        }
        
        
    }
    
    // Removes task from task list and sends it to the social timeline if its academic. Also displays an animation to show completion
    @objc func finishTask(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = TaskList.sharedInstance.currentTasks[indexPath.row]
        let tempTask = Task(name: task.name, time: task.time, category: task.category, pinned: false, completed: true)
        TaskList.sharedInstance.removeTask(task: task)
        
        if task.category == .academic{
            TaskList.sharedInstance.amtOfAcademicTasks -= 1
        } else if task.category == .social{
            TaskList.sharedInstance.amtOfSocialTasks -= 1
        } else if task.category == .health{
            TaskList.sharedInstance.amtOfHealthTasks -= 1
        } else if task.category == .events{
            TaskList.sharedInstance.amtOfEventsTasks -= 1
        } else {
            TaskList.sharedInstance.amtOfOtherTasks -= 1
        }
        
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])

        TaskList.sharedInstance.addTask(task: tempTask)
        
        showAnimation(category: tempTask.category)
        
        
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
    
    // Moves task from incomplete to complete section
    @objc func moveTask(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = TaskList.sharedInstance.incompleteTasks[indexPath.row]
        let tempTask = Task(name: task.name, time: task.time, category: task.category, pinned: false)
        TaskList.sharedInstance.removeTask(task: task)
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        
        TaskList.sharedInstance.addTask(task: tempTask)
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        
        TaskList.sharedInstance.incompleteTasks = mergeSort(TaskList.sharedInstance.incompleteTasks)
        TaskList.sharedInstance.currentTasks = mergeSort(mergeSort(TaskList.sharedInstance.currentTasks))
        

        
        collectionView?.reloadData()
    }
    
    @objc func removeTaskFromIncomplete(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = TaskList.sharedInstance.incompleteTasks[indexPath.row]
        TaskList.sharedInstance.removeTask(task: task)
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        
    }
    
    @objc func removeTaskFromCurrent(_ sender: UIButton){
        let point = sender.convert(CGPoint.zero, to: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: point) else {
            return
        }
        let task = TaskList.sharedInstance.currentTasks[indexPath.row]
        TaskList.sharedInstance.removeTask(task: task)
        TaskList.sharedInstance.calculateCurrentTasks()
        TaskList.sharedInstance.calculateIncompleteTasks()
        collectionView.deleteItems(at: [indexPath])
        if task.category == .academic{
            TaskList.sharedInstance.amtOfAcademicTasks -= 1
            var index = TaskList.sharedInstance.rangeOfTasks.firstIndex(of: "A")!
            TaskList.sharedInstance.rangeOfTasks.remove(at: index)
        } else if task.category == .social{
            TaskList.sharedInstance.amtOfSocialTasks -= 1
            var index = TaskList.sharedInstance.rangeOfTasks.firstIndex(of: "S")!
            TaskList.sharedInstance.rangeOfTasks.remove(at: index)
        } else if task.category == .health{
            TaskList.sharedInstance.amtOfHealthTasks -= 1
            var index = TaskList.sharedInstance.rangeOfTasks.firstIndex(of: "H")!
            TaskList.sharedInstance.rangeOfTasks.remove(at: index)
        } else if task.category == .events{
            TaskList.sharedInstance.amtOfEventsTasks -= 1
            var index = TaskList.sharedInstance.rangeOfTasks.firstIndex(of: "E")!
            TaskList.sharedInstance.rangeOfTasks.remove(at: index)
        } else {
            TaskList.sharedInstance.amtOfOtherTasks -= 1
            var index = TaskList.sharedInstance.rangeOfTasks.firstIndex(of: "O")!
            TaskList.sharedInstance.rangeOfTasks.remove(at: index)
        }
    }
    
}



