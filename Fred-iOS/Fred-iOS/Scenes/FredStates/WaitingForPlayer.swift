//
//  WaitingForPlayer.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForPlayer: FredGameState {
    
    /// Timer variables
    var pauseTimeCounter: TimeInterval = 0
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "WaitingForPlayer")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Start timer
        pauseTimeCounter = 0
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Nothing to declare :)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        switch stateClass {
        case is PlayerPressButton.Type, is GameOver.Type:
            return true
        default:
            return false
        }
    }
    
    override func update(deltaTime: TimeInterval) {
        /// Keep track of the time since the last update.
        pauseTimeCounter += deltaTime
        
        /// If an interval of pauseInterval has passed since the previous update GameOver
        if pauseTimeCounter > GameScene.intervalPlayerWaiting {
            game.fredGameStateMachine.enter(GameOver.self)
        }
    }
}
