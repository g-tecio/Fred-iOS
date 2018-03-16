//
//  WaitingForPlayer.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class WaitingForPlayer: FredState {
    
    /// Keeps track of waiting time
    var pauseTimeCounter: TimeInterval = 0
    
    /// Defines the time interval to wait for Player
    static let pauseInterval = GameScene.intervalPlayerWaiting
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "WaitingForPlayer")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Start timer, if reaches pauseInterval it will go to GameOver state
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
        if pauseTimeCounter > WaitingForPlayer.pauseInterval {
            print(pauseTimeCounter)
            if !game.stateFredMachine.enter(GameOver.self) {
                print("Error 28")
            }
        }
    }
}
