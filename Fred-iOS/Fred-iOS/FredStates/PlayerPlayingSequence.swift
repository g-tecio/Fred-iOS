//
//  PlayerPlayingSequence.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerPlayingSequence: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "PlayerPlayingSequence")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// State
        game.scoreboard.stateSprint.texture = game.scoreboard.state4Texture
        
        /// If Player played full sequence go to FredAddsRandomButton state
        if (game.sequenceList.count == game.sequenceCounter) {
            game.stateFredMachine.enter(FredAddsRandomButton.self)
        }
        else {
            /// Go to WaitingForPlayer state
            game.stateFredMachine.enter(WaitingForPlayer.self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        if nextState is WaitingForPlayer {
            
            /// Nothing to declare :)
        }
        if nextState is FredAddsRandomButton {
            
            /// Game variables
            game.sequenceCounter = 0
            game.cycles += 1
            
            /// Set Sprites
            game.scoreboard.playerLabel.fontColor = .lightGray
            game.scoreboard.playerCorrect.texture = game.scoreboard.playerCorrectOff
            game.scoreboard.fredLabel.fontColor = .blue
            game.scoreboard.fredCount.text = "0"
            
            game.scoreboard.playerStars[(game.cycles-1) % 5].texture = game.scoreboard.starOn
            
            if (game.cycles % 5) == 0 {
                for i in 1...5 {
                    game.scoreboard.playerStars[i-1].texture = game.scoreboard.starOff
                }
            }
            if (game.cycles >= 5) {
                game.scoreboard.playerStars[Int(game.cycles/5)+4].texture = game.scoreboard.starOn
            }
            
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is WaitingForPlayer.Type, is FredAddsRandomButton.Type:
            return true
        default:
            return false
        }
    }
}
