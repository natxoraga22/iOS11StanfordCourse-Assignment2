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
    
    private(set) var deck = [SetCard]()
    private(set) var dealtCards = [SetCard]()
    private(set) var selectedCards = [SetCard]()
    var selectedCardsMatch: Bool? {
        get {
            if selectedCards.count < 3 { return nil }
            else { return selectedCards[0].matchesWith(selectedCards[1], selectedCards[2]) }
        }
    }
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
        for _ in 1...SetGame.numberOfStartingCards { dealtCards.append(getRandomCard()!) }
    }
    
    private func getRandomCard() -> SetCard? {
        return !deck.isEmpty ? deck.remove(at: Int.random(deck.count)) : nil
    }
    
    func dealThreeMoreCards() {
        precondition(deck.count >= 3, "Not enough cards in deck")
        if let match = selectedCardsMatch, match { replaceDealtSelectedCards() }
        else {
            for _ in 1...3 { dealtCards.append(getRandomCard()!) }
        }
    }
    
    private func replaceDealtSelectedCards() {
        for selectedCard in selectedCards {
            if let randomCard = getRandomCard() { dealtCards[dealtCards.index(of: selectedCard)!] = randomCard }
        }
        selectedCards.removeAll()
    }
    
    func chooseCard(at index: Int) {
        // store chosen card
        let chosenCard: SetCard? = dealtCards.indices.contains(index) ? dealtCards[index] : nil
        
        // process previous match/mismatch
        if let previousMatch = selectedCardsMatch {
            if previousMatch {
                matchedCards.append(contentsOf: selectedCards)
                replaceDealtSelectedCards()
            }
            else { selectedCards.removeAll() }
        }
        
        if let card = chosenCard, !matchedCards.contains(dealtCards[index]) {
            // card already selected --> deselect
            if selectedCards.contains(card) {
                selectedCards.remove(at: selectedCards.index(of: card)!)
                score += SetGame.deselectScore
            }
            // card not selected and not changed (processing previous match can change the dealt cards) --> select
            else if dealtCards[index] == card { selectedCards += [card] }
            
            // Check match/mismatch
            if let newMatch = selectedCardsMatch {
                if newMatch { score += SetGame.matchScore }
                else { score += SetGame.mismatchScore }
            }
        }
    }
    
}
