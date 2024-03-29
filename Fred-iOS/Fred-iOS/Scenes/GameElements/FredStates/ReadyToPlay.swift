//
//  ReadyToPlay.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class ReadyToPlay: FredGameState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "ReadyToPlay")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
		
        /// Set Start Switch to Off
		game.gameControls.startSwitch.valueSwitchSK = false
		
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is StartGame.Type
    }
}
