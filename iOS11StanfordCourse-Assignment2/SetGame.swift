//
//  SetGame.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 17/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


class SetGame {
    
    private static let numberOfStartingCards = 12
    
    private var deck = [SetCard]()
    private(set) var dealtCards = [SetCard]()
    private(set) var selectedCards = [SetCard]()
    private(set) var matchedCards = [SetCard]()
    
    // Score
    private(set) var score = 0
    private static let matchScore = +5
    private static let mismatchScore = -3
    private static let deselectScore = -1
    
    
    init() {
        // create a standard Set deck (one card for each combination)
        for number in SetCard.minNumber...SetCard.maxNumber {
            for symbol in SetCardSymbol.allCases {
                for shading in SetCardShading.allCases {
                    for color in SetCardColor.allCases {
                        deck += [SetCard(number: number, symbol: symbol, shading: shading, color: color)]
                    }
                }
            }
        }
        // deal the starting cards
        for _ in 1...SetGame.numberOfStartingCards { dealtCards.append(getRandomCard()) }
    }
    
    private func getRandomCard() -> SetCard {
        return deck.remove(at: Int.random(deck.count))
    }
    
    func dealThreeMoreCards() {
        if !matchedCards.isEmpty { replaceMatchedCards() }
        else {
            for _ in 1...3 { dealtCards.append(getRandomCard()) }
        }
    }
    
    private func replaceMatchedCards() {
        for matchedCard in matchedCards { dealtCards[dealtCards.index(of: matchedCard)!] = getRandomCard() }
        matchedCards.removeAll()
    }
    
    func chooseCard(at index: Int) {
        if (dealtCards.indices.contains(index)) {
            let chosenCard = dealtCards[index]
            
            // process previous mismatch
            if selectedCards.count == 3 { selectedCards.removeAll() }
            
            // card already selected --> deselect
            if selectedCards.contains(chosenCard) {
                selectedCards.remove(at: selectedCards.index(of: chosenCard)!)
                score += SetGame.deselectScore
            }
            else {
                if !matchedCards.contains(chosenCard) { selectedCards += [chosenCard] }
                
                // process previous match
                replaceMatchedCards()
                
                // try to match
                if (selectedCards.count == 3) {
                    if (selectedCards[0].matchesWith(selectedCards[1], selectedCards[2])) {
                        // MATCH!
                        matchedCards.append(contentsOf: selectedCards)
                        selectedCards.removeAll()
                        score += SetGame.matchScore
                    }
                    else { score += SetGame.mismatchScore }
                }
            }
        }
    }
    
}
