//
//  PlayerReleaseButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerReleaseButton: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "PlayerReleaseButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Button release
        game.releaseButtonFunction()
        /// If button is correct go to PlayerPlayingSequence state
        if (game.idButtonPlaying == game.sequenceList[game.sequenceCounter]) {
            if !game.stateFredMachine.enter(PlayerPlayingSequence.self) {
                print("Error 29")
            }
        }
        /// If button is wrong then go to GameOver state
        else {
            if !game.stateFredMachine.enter(GameOver.self) {
                print("Error 30")
            }
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        if nextState is PlayerPlayingSequence {
            
            /// Increase sequenceCounter
            game.sequenceCounter += 1
        }
        if nextState is GameOver {
            
            /// Nothing to declare :)
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is PlayerPlayingSequence.Type, is GameOver.Type:
            return true
        default:
            return false
        }
    }
}
