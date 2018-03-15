//
//  GameOver.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: FredState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "GameOver")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        // Show Game Over Message
        game.gameOverMessage.gameOverLabel.isHidden = false

    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        // Remove Game Over Message
        game.gameOverMessage.gameOverLabel.isHidden = true
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is ReadyToPlay.Type
    }
}
