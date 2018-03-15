//
//  FredPlayingSequence.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredPlayingSequence: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredPlayingSequence")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// If Fred played full sequence go to PlayerPlayingSequence state
        if (game.sequenceList.count == game.sequenceCounter) {
            if !game.stateFredMachine.enter(PlayerPlayingSequence.self) {
                print("Error 22")
            }
        }
        else {
            game.scoreboard.fredCount.text = "\(game.sequenceCounter+1)"
            /// If is the last button of the sequence turn on fredNew sprite
            if (game.sequenceCounter+1 == game.sequenceList.count) {
                game.scoreboard.fredNew.texture = game.scoreboard.fredNewOn
                game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOff
            }
            /// Fred will press next button on sequence
            if !game.stateFredMachine.enter(FredPressButton.self) {
                print("Error 23")
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        if nextState is FredPressButton {
            
            /// Nothing to declare :)
        }
        if nextState is PlayerPlayingSequence {
            
            /// Set Game Variables
            game.sequenceCounter = 0
            
            /// Set Sprites
            game.scoreboard.fredLabel.fontColor = .lightGray
            game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOff
            game.scoreboard.fredNew.texture = game.scoreboard.fredNewOff
            game.scoreboard.playerLabel.fontColor = .blue
            game.scoreboard.playerCount.text = "0"
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is FredPressButton.Type, is PlayerPlayingSequence.Type:
            return true
        default:
            return false
        }
    }
}
