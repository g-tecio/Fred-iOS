//
//  FredPressButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredPressButton: FredGameState {
    
    /// Timer Variables
    var pauseTimeCounter: TimeInterval = 0
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredPressButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        // Get next Button from the sequence and play it once counter reaches pauseInterval
        game.idButtonPlaying = game.sequenceList[game.sequenceCounter]
        
        /// Start timer
        pauseTimeCounter = 0
        
        /// Button Press Action Starts
		game.pressButtonFunction(buttonId: game.idButtonPlaying, multiple: false)
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Nothing to declare :)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredReleaseButton.Type
    }
    
    override func update(deltaTime: TimeInterval) {
        /// Keep track of the time since the last update.
        pauseTimeCounter += deltaTime
        
        /// If an interval of pauseInterval has passed go to FredReleaseButton state
        if pauseTimeCounter > Double(GameData.shared.framesButtonAnimation)/60.0 {
           game.fredGameStateMachine.enter(FredReleaseButton.self)
        }
    }
}
