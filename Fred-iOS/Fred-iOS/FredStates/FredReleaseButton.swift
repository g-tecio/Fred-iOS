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
    
    /// Timer variables
    var pauseTimeCounter: TimeInterval = 0
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredReleaseButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Start button release action
        game.releaseButtonFunction()
        pauseTimeCounter = 0
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Increase sequenceCounter
        game.sequenceCounter += 1
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredPlayingSequence.Type
    }
    
    override func update(deltaTime: TimeInterval) {
        /// Keep track of the time since the last update.
        pauseTimeCounter += deltaTime
        
        /// If an interval of pauseInterval has passed since the previous update
        if pauseTimeCounter > GameScene.intervalBetweenTurns {
            game.stateFredMachine.enter(FredPlayingSequence.self)
        }
    }
}
