//
//  FredAddsRandomButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class FredAddsRandomButton: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "FredAddsRandomButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// New Value added to end of sequence
        game.sequenceList.append(game.newValue.nextInt())
        
        /// State change to FredPlayingSequence
        if !game.stateFredMachine.enter(FredPlayingSequence.self) {
            print("Error 21")
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Set Sprit for Fred's turn
        game.scoreboard.fredLabel.fontColor = .blue
        game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOn
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredPlayingSequence.Type
    }
}
