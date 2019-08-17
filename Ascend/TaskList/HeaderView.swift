//
//  HeaderView.swift
//  YoutubeHomeDemo
//
//  Created by Max Dunaevschi on 7/27/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import UIKit

class HeaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHeader()
        //self.backgroundColor = UIColor.blue
    }
    
    // Creates elements that will be placed intp the header section
    let headerSectionLabel: UILabel = {
        let label = UILabel()
        //label.text = "Current"
        //label.font = label.font.withSize(20)
        //label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        //label.font = UIFont(name: "system-semibold", size: 30)
        //label.backgroundColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    /*let amtTasksLeftLabel: UILabel = {
        let label = UILabel()
        label.font = label.font.withSize(15)
        //label.backgroundColor = UIColor.green
        return label
    }()*/
    
    // Positions the elements within the header view
    func setupHeader(){
        addSubview(headerSectionLabel)
        //addSubview(amtTasksLeftLabel)
        //addConstraintsWithFormat(format: "H:|-16-[v0(150)]-193-[v1(50)]", views: headerSectionLabel, amtTasksLeftLabel)
        addConstraintsWithFormat(format: "H:|-16-[v0(250)]", views: headerSectionLabel)
        addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: headerSectionLabel)
        //addConstraintsWithFormat(format: "V:|-40-[v0(30)]", views: amtTasksLeftLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
