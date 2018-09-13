//
//  PlayerPlayingSequence.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerPlayingSequence: FredGameState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "PlayerPlayingSequence")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
		
        /// If Player played full sequence go to FredAddsRandomButton state
        if (game.sequenceList.count == game.sequenceCounter) {
            game.fredGameStateMachine.enter(FredAddsRandomButton.self)
        }
        else {
            /// Go to WaitingForPlayer state
            game.fredGameStateMachine.enter(WaitingForPlayer.self)
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        if nextState is WaitingForPlayer {
            
            /// Nothing to declare :)
        }
        if nextState is FredAddsRandomButton {
            /// Game variables
            game.sequenceCounter = 0
            game.cycles += 1
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
