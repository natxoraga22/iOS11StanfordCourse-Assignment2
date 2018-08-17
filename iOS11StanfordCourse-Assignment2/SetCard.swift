//
//  SetCard.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 17/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


struct SetCard: Equatable {
    
    static let minNumber = 1
    static let maxNumber = 3
    
    let number: Int
    let symbol: SetCardSymbol
    let shading: SetCardShading
    let color: SetCardColor
    
}

enum SetCardSymbol {
    case symbol1, symbol2, symbol3
    static var allCases: [SetCardSymbol] = [.symbol1, .symbol2, .symbol3]
}

enum SetCardShading {
    case shading1, shading2, shading3
    static var allCases: [SetCardShading] = [.shading1, .shading2, .shading3]
}

enum SetCardColor {
    case color1, color2, color3
    static var allCases: [SetCardColor] = [.color1, .color2, .color3]
}
