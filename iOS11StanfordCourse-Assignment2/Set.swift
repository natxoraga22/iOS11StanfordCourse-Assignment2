//
//  Set.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 17/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


class Set {
    
    private static let numberOfStartingCards = 12
    
    private var deck = [SetCard]()
    private(set) var dealtCards = [SetCard]()
    private var selectedCards = [SetCard]()
    private var matchedCards = [SetCard]()
    
    
    init() {
        // Create a standard Set deck (one card for each combination)
        for number in SetCard.minNumber...SetCard.maxNumber {
            for symbol in SetCardSymbol.allCases {
                for shading in SetCardShading.allCases {
                    for color in SetCardColor.allCases {
                        deck += [SetCard(number: number, symbol: symbol, shading: shading, color: color)]
                    }
                }
            }
        }
        // Deal the starting cards
        for _ in 1...Set.numberOfStartingCards { dealRandomCard() }
    }
    
    private func dealRandomCard() {
        dealtCards.append(deck.remove(at: Int.random(deck.count)))
    }
    
    func dealMoreCards() {
        for _ in 1...3 { dealRandomCard() }
    }
    
    func chooseCard() {
        
    }
    
}
