//
//  FredPlayingSequence.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredPlayingSequence: FredGameState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredPlayingSequence")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
		
        /// If Fred played full sequence go to PlayerPlayingSequence state
        if (game.sequenceList.count == game.sequenceCounter) {
            game.fredGameStateMachine.enter(PlayerPlayingSequence.self)
        }
        else {
            /// Fred will press next button on sequence
            game.fredGameStateMachine.enter(FredPressButton.self)
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
