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
    
    func matchesWith(_ cardToMatch1: SetCard, _ cardToMatch2: SetCard) -> Bool {
        if (self.number == cardToMatch1.number && self.number == cardToMatch2.number) ||
            (self.number != cardToMatch1.number && self.number != cardToMatch2.number && cardToMatch1.number != cardToMatch2.number) {
            if self.symbol.matchesWith(cardToMatch1.symbol, cardToMatch2.symbol) {
                if (self.shading.matchesWith(cardToMatch1.shading, cardToMatch2.shading)) {
                    if (self.color.matchesWith(cardToMatch1.color, cardToMatch2.color)) {
                        return true
                    }
                }
            }
        }
        return false
    }
    
}

enum SetCardSymbol {
    case symbol1, symbol2, symbol3
    static var allCases: [SetCardSymbol] = [.symbol1, .symbol2, .symbol3]
    
    func matchesWith(_ symbolToMatch1: SetCardSymbol, _ symbolToMatch2: SetCardSymbol) -> Bool {
        return (self == symbolToMatch1 && self == symbolToMatch2) || (self != symbolToMatch1 && self != symbolToMatch2 && symbolToMatch1 != symbolToMatch2)
    }
}

enum SetCardShading {
    case shading1, shading2, shading3
    static var allCases: [SetCardShading] = [.shading1, .shading2, .shading3]
    
    func matchesWith(_ shadingToMatch1: SetCardShading, _ shadingToMatch2: SetCardShading) -> Bool {
        return (self == shadingToMatch1 && self == shadingToMatch2) || (self != shadingToMatch1 && self != shadingToMatch2 && shadingToMatch1 != shadingToMatch2)
    }
}

enum SetCardColor {
    case color1, color2, color3
    static var allCases: [SetCardColor] = [.color1, .color2, .color3]
    
    func matchesWith(_ colorToMatch1: SetCardColor, _ colorToMatch2: SetCardColor) -> Bool {
        return (self == colorToMatch1 && self == colorToMatch2) || (self != colorToMatch1 && self != colorToMatch2 && colorToMatch1 != colorToMatch2)
    }
}
