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
        
        /// If Player played full sequence go to FredAddsRandomButton state
        if (game.sequenceList.count == game.sequenceCounter) {
            if !game.stateFredMachine.enter(FredAddsRandomButton.self) {
                print("Error 26")
            }
        }
        else {
            /// Go to WaitingForPlayer state
            if !game.stateFredMachine.enter(WaitingForPlayer.self) {
                print("Error 27")
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        if nextState is WaitingForPlayer {
            
            /// Nothing to declare :)
        }
        if nextState is FredAddsRandomButton {
            
            game.sequenceCounter = 0
            /// Set Sprites
            game.scoreboard.playerLabel.fontColor = .lightGray
            game.scoreboard.playerCorrect.texture = game.scoreboard.playerCorrectOff
            game.scoreboard.fredLabel.fontColor = .blue
            game.scoreboard.fredCount.text = "0"
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
