//
//  SetViewController.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 17/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import UIKit


class SetViewController: UIViewController {

    // Model
    private var game: SetGame! { didSet { updateViewFromModel() } }
    
    @IBOutlet private weak var dealMoreCardsButton: UIButton!
    @IBOutlet private var cardButtons: [UIButton]!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = SetGame()
        for cardButton in cardButtons { cardButton.layer.cornerRadius = 8.0 }
    }
    
    @IBAction private func touchNewGame() {
        game = SetGame()
    }
    
    @IBAction private func touchDealThreeMoreCards() {
        game.dealThreeMoreCards()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        game.chooseCard(at: cardButtons.index(of: sender)!)
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        // card buttons
        for index in cardButtons.indices {
            let cardButton = cardButtons[index]
            if index < game.dealtCards.count {
                let dealtCard = game.dealtCards[index]
                // matched card
                if game.matchedCards.contains(dealtCard) { hideCardButton(cardButton) }
                else {
                    updateCardButtonContent(cardButton, fromCard:dealtCard)
                    
                    // selected card (can be matched, mismatched or simply selected)
                    if game.selectedCards.contains(dealtCard) {
                        cardButton.layer.borderWidth = 3.0
                        if let cardMatched = game.selectedCardsMatch {
                            if cardMatched { cardButton.layer.borderColor = UIColor.green.cgColor }
                            else { cardButton.layer.borderColor = UIColor.red.cgColor }
                        }
                        else { cardButton.layer.borderColor = UIColor.blue.cgColor }
                    }
                    // not selected card
                    else { cardButton.layer.borderWidth = 0.0 }
                }
            }
            // card not dealt
            else { hideCardButton(cardButton) }
        }
        // enable/disable deal more cards button
        let uiIsFull = !(game.selectedCardsMatch ?? false) && game.dealtCards.count == cardButtons.count
        dealMoreCardsButton.isEnabled = game.deck.count >= 3 && !uiIsFull
        
        // score
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func hideCardButton(_ cardButton: UIButton) {
        cardButton.setTitle(nil, for: UIControlState.normal)
        cardButton.setAttributedTitle(nil, for: UIControlState.normal)
        cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        cardButton.layer.borderWidth = 0.0
    }
    
    private func updateCardButtonContent(_ cardButton: UIButton, fromCard card: SetCard) {
        // symbol
        var symbol = ""
        switch card.symbol {
            case .symbol1: symbol = "▲"
            case .symbol2: symbol = "●"
            case .symbol3: symbol = "■"
        }
        // number
        var textArray = [String]()
        for _ in 1...card.number { textArray += [symbol] }
        let text = textArray.joined(separator: "\n")
        // color
        var strokeColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch card.color {
            case .color1: strokeColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            case .color2: strokeColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
            case .color3: strokeColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
        }
        // shading
        var foregroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        switch card.shading {
            case .shading1: foregroundColor = strokeColor                           // filled
            case .shading2: foregroundColor = strokeColor.withAlphaComponent(0.25)  // "stripped"
            case .shading3: break                                                   // outline
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.9
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor: foregroundColor,
            .strokeColor: strokeColor,
            .strokeWidth: -5.0,
            .paragraphStyle: paragraphStyle
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        cardButton.setAttributedTitle(attributedText, for: UIControlState.normal)
        cardButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    }

}
