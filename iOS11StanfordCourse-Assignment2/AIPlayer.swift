//
//  AIPlayer.swift
//  iOS11StanfordCourse-Assignment2
//
//  Created by Natxo Raga Llorens on 21/8/18.
//  Copyright © 2018 Natxo Raga. All rights reserved.
//

import Foundation


class AIPlayer {
    
    private static let minThinkingTime = 10.0
    private static let maxThinkingTime = 20.0
    
    private var status = AIPlayerStatus.idle
    private var game: SetGame
    
    private var currentTimer: Timer?
    
    
    init(game: SetGame) {
        self.game = game
    }
    
    func searchMatch(onMatchFound matchFoundCallback: @escaping ((_: [SetCard]) -> Void)) {
        status = .thinking
        
        if currentTimer == nil {
            let timeInterval = Double.random(min: AIPlayer.minThinkingTime, max: AIPlayer.maxThinkingTime)
            currentTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { (timer) in
                if let matchCards = self.game.getMatchInDealtCards() {
                    self.status = .matchFound
                    matchFoundCallback(matchCards)
                }
            }
        }
    }
    
    func stopSearching() {
        currentTimer?.invalidate()
        currentTimer = nil
    }
    
}

enum AIPlayerStatus {
    case idle
    case thinking
    case almostDone
    case matchFound
}
