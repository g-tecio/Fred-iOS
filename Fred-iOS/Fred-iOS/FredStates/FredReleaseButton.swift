//
//  FredReleaseButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredReleaseButton: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredReleaseButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Start button release action
        game.releaseButtonFunction()
        if !game.stateFredMachine.enter(FredPlayingSequence.self) {
            print("Error 25")
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Increase sequenceCounter
        game.sequenceCounter += 1
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredPlayingSequence.Type
    }
    
}
