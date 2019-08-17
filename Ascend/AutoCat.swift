//
//  AutoCat.swift
//  Ascend
//
//  Created by Isabelle Quaye on 7/30/19.
//  Copyright © 2019 Max Dunaevschi. All rights reserved.
//

import Foundation
import UIKit

var AutoCatDictionary = ["academic" : ["hw", "homework", "assignment", "pset","problem set", "exam", "class", "lecture", "recitation", "oh",
                                       "office hours", "study group", "study session", "test", "essay", "paper", "tutorial",  "tutoring"],
                         "social" : ["party", "concert", "bar", "pub", "show", "performance", "outing", "get together", "bbq", "brunch", "club", "meeting"],
                         "events": ["interview", "career fair", "flight", "trip", "retreat", "counsellor", "advisor"],
                         "health" : ["doctor's appointment", "gym", "workout", "run", "hiking", "swimming", "pe", "fitness", "walk", "walking", "appointment", "jogging"]
    
]

func AutoCat(_ taskName: String) -> String {
    let taskName_lowercase = taskName.lowercased()
    for (key,value) in AutoCatDictionary {
        for element in value {
            if taskName_lowercase.contains(element) {
                return key
            }
        }
    }
    return "other"
}

