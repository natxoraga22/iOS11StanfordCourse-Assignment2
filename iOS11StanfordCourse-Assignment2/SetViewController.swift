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
    private var game: Set! { didSet { updateViewFromModel() } }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = Set()
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let cardButton = cardButtons[index]
            if index < game.dealtCards.count {
                let dealtCard = game.dealtCards[index]
                updateCardButtonContent(cardButton, fromCard:dealtCard)
            }
            else {
                cardButton.setTitle(nil, for: UIControlState.normal)
                cardButton.setAttributedTitle(nil, for: UIControlState.normal)
                cardButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            }
        }
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
        var strokeWidth = 0.0
        switch card.shading {
            // filled
            case .shading1: foregroundColor = strokeColor
            // "stripped"
            case .shading2:
                strokeWidth = -5.0
                foregroundColor = strokeColor.withAlphaComponent(0.25)
            // outline
            case .shading3: strokeWidth = 5.0
        }
        
        let attributes: [NSAttributedStringKey: Any] = [
            .foregroundColor: foregroundColor,
            .strokeColor: strokeColor,
            .strokeWidth: strokeWidth
        ]
        let attributedText = NSAttributedString(string: text, attributes: attributes)
        cardButton.setAttributedTitle(attributedText, for: UIControlState.normal)
    }

}
