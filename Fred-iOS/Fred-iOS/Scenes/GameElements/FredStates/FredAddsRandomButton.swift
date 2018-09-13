//
//  FredAddsRandomButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredAddsRandomButton: FredGameState {
    
    /// Timer variables
    var pauseTimeCounter: TimeInterval = 0
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredAddsRandomButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
		
		/// New Value added to end of sequence
        game.sequenceList.append(game.newValue.nextInt())
 
		/// Start timer
        pauseTimeCounter = 0
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredPlayingSequence.Type
    }
    
    override func update(deltaTime: TimeInterval) {
        /// Keep track of the time since the last update.
        pauseTimeCounter += deltaTime
        
        /// If an interval of pauseInterval has passed got to FredPlayingSequence state
        if pauseTimeCounter > Double(GameData.shared.framesBetweenCycles)/60 {
            game.fredGameStateMachine.enter(FredPlayingSequence.self)
        }
    }
}
