//
//  GameOver.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameOver: FredGameState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "GameOver")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// State
        game.scoreboard.stateSprint.texture = game.scoreboard.state5Texture

        /// Show Game Over Message
        game.gameOverMessage.gameOverLabel.isHidden = false

    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        // Remove Game Over Message
        game.gameOverMessage.gameOverLabel.isHidden = true
		
		/// Button Configuration
		game.addChild(game.gameControls.configButtonSprite)
		game.addChild(game.gameControls.scoreButtonSprite)
		game.gameControls.startSwitch.addChild(game.gameControls.startSwitch.switchBar)
		game.gameControls.startSwitch.labelInsideSwitchSK.text = ""
		
		/// Activate Effect
		game.lastPosition.x = -100
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is ReadyToPlay.Type
    }
}