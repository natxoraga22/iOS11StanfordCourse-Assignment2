//
//  Random.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 17/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


extension Int {
    static func random(_ upperBound: Int) -> Int {
        if upperBound > 0 { return Int(arc4random_uniform(UInt32(upperBound))) }
        else { return 0 }
    }
}
