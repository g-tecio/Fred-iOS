//
//  PlayerPressButton.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/14/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerPressButton: FredGameState {
    
    required init(game: GameScene) {
        super.init(game: game, associatedStateName: "PlayerPressButton")
    }
    
    override func didEnter(from previousState: GKState?) {
        super.didEnter(from: previousState)
        
        /// Start Play of Button
		game.pressButtonFunction(buttonId: game.idButtonPlaying, multiple: false)
        /// If button is correct set playerCorrectOn
        if (game.idButtonPlaying == game.sequenceList[game.sequenceCounter]) {
            game.score += 1
			game.gameControls.startSwitch.labelInsideSwitchSK.text = "\(game.score)"
        }
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is PlayerReleaseButton.Type
    }
}
