//
//  MenuBar.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/24/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class MenuBar: UIView, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Creates element for MenuBar
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        //cv.backgroundColor = UIColor.blue
        //cv.backgroundColor = UIColor(red: 91/255, green: 185/255, blue: 235/255, alpha: 1)
        cv.backgroundColor = UIColor(named: "navbarColor-1")
        return cv
    }()
    
    let headerTaskLabel: UILabel = {
        let label = UILabel()
        label.text = "Tasks"
        label.textColor = UIColor.black
        //label.backgroundColor = UIColor.blue
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor.white
        return label
    }()
    
    var overviewLabel: UILabel = {
        let label = UILabel()
        label.text = "overview"
        label.textColor = UIColor.black.withAlphaComponent(0.7)
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.yellow
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Done", for: .normal)
        return button
    }()
    
    let pencilButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "editPen-white"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        collectionView.addSubview(headerTaskLabel)
        //collectionView.addSubview(overviewLabel)
        collectionView.addSubview(editButton)
        collectionView.addSubview(pencilButton)
        addConstraintsWithFormat(format: "H:|-14-[v0(150)]-195-[v1(50)]", views: headerTaskLabel, editButton)
        addConstraintsWithFormat(format: "H:|-359-[v0(30)]", views: pencilButton)
        addConstraintsWithFormat(format: "V:|[v0(50)]|", views: headerTaskLabel)
        //addConstraintsWithFormat(format: "V:|[v0(20)]", views: overviewLabel)
        addConstraintsWithFormat(format: "V:|-15-[v0(20)]", views: editButton)
        addConstraintsWithFormat(format: "V:|-15-[v0(35)]", views: pencilButton)
        
        hideFinish()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hidePencil(){
        pencilButton.isHidden = true
    }
    
    func hideFinish(){
        editButton.isHidden = true
    }
    
    func showPencil(){
        pencilButton.isHidden = false
    }
    
    func showFinish(){
        editButton.isHidden = false
    }
    
}


class TopSection: UIView,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Creates element for MenuBar
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //cv.backgroundColor = UIColor(red: 230/255, green: 32/255, blue: 32/255, alpha: 1)
        //cv.backgroundColor = UIColor.blue
        //cv.backgroundColor = UIColor(red: 91/255, green: 185/255, blue: 235/255, alpha: 1)
        //cv.backgroundColor = UIColor(named: "navbarColor-1")
        //cv.backgroundView = UIImageView(image: UIImage(named: "11"))
        return cv
    }()
    
    let overviewButton: UIButton = {
        let button = UIButton()
        //button.backgroundColor = UIColor.yellow
        button.setImage(UIImage(named: "upward-white"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupTopBar()
    }
    
    // Sets up the top section of the navigation bar
    func setupTopBar(){
        addSubview(collectionView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: collectionView)
        addConstraintsWithFormat(format: "V:|[v0]|", views: collectionView)
        
        collectionView.addSubview(overviewButton)
        //collectionView.backgroundColor = UIColor(red: 91/255, green: 185/255, blue: 235/255, alpha: 1)
        collectionView.backgroundColor = UIColor(named: "navbarColor-1")
        collectionView.addConstraintsWithFormat(format: "H:|-190-[v0(35)]", views: overviewButton)
        collectionView.addConstraintsWithFormat(format: "V:|-8-[v0(35)]", views: overviewButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
