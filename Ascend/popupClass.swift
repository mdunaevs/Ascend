//
//  popupClass.swift
//  Ascend
//
//  Created by Isabelle Quaye on 8/1/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import Foundation
import UIKit

class Popup: UIView {
    var toplabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        label.backgroundColor  = .white
        return label
    }()

        var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.text = "1 credit"
        label.textAlignment = .center
        return label
    }()
    
    
        var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Something"
        label.textAlignment = .center
        label.numberOfLines = 3
        return label
    }()
    
        var container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    var imageIcon : UIImageView = {
        let icon = UIImageView()
        icon.contentMode = .scaleAspectFit
        return icon
    }()
    var bottomlabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor  = .white
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 5
        return label
    }()
    
        lazy var stack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageIcon,titleLabel,subtitleLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setCustomSpacing(0, after: stack.arrangedSubviews[0])
        stack.axis = .vertical
        stack.setCustomSpacing(-50, after: imageIcon)
        stack.setCustomSpacing(-120, after: titleLabel)
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    @objc fileprivate func animateOut() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
            self.alpha = 0
        }) { (complete) in
            if complete {
                self.removeFromSuperview()
            }
        }
    }
    
    @objc fileprivate func animateIn() {
        self.container.transform = CGAffineTransform(translationX: 0, y: -self.frame.height)
        self.alpha = 1
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.container.transform = .identity
            self.alpha = 1
        })
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animateOut)))
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
        self.frame = UIScreen.main.bounds
        self.addSubview(container)
        container.layer.cornerRadius = 5
        container.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45).isActive = true
        
        container.addSubview(toplabel)
        toplabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        toplabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        toplabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        toplabel.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        container.addSubview(bottomlabel)
        bottomlabel.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        bottomlabel.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        bottomlabel.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.1).isActive = true
        bottomlabel.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true

        container.addSubview(stack)
        stack.topAnchor.constraint(equalTo: toplabel.bottomAnchor, constant:50).isActive = true
        stack.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: bottomlabel.topAnchor, constant: 20).isActive = true
        stack.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        stack.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        stack.heightAnchor.constraint(equalTo: container.heightAnchor, multiplier: 0.8).isActive = true
        
        
        animateIn()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
