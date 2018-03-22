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
        // State
        game.scoreboard.stateSprint.texture = game.scoreboard.state1Texture
        
        /// Enable Start Button
        game.gameControls.startButtonSprite.texture = game.gameControls.startOnTexture
        game.gameControls.startLabel.text = "Press to Play"
    }
    
    override func willExit(to nextState: GKState) {
        super.willExit(to: nextState)
        
        /// Reset variables to Start Game
        game.sequenceCounter = 0
        game.sequenceList.removeAll()
        game.cycles = 0
        game.score = 0
        
        /// Labels and textures set to Start Game
        game.gameControls.startButtonSprite.texture = game.gameControls.startOffTexture
        game.gameControls.startLabel.text = "Playing"
        game.scoreboard.fredLabel.fontColor = .lightGray
        game.scoreboard.fredRepeat.texture = game.scoreboard.fredRepeatOff
        game.scoreboard.fredNew.texture = game.scoreboard.fredNewOff
        game.scoreboard.fredCount.text = "0"
        game.scoreboard.fredCount.fontColor = .black
        game.scoreboard.playerLabel.fontColor = .lightGray
        game.scoreboard.playerCorrect.texture = game.scoreboard.playerCorrectOff
        game.scoreboard.playerError.texture = game.scoreboard.playerErrorOff
        game.scoreboard.playerCount.text = "0"
        game.scoreboard.playerCount.fontColor = .darkGray
        game.scoreboard.score.text = "0"
        game.scoreboard.score.fontColor = .black
        for i in 1...10 {
            game.scoreboard.playerStars[i-1].texture = game.scoreboard.starOff
        }
    }
    
    override func isValidNextState(_ stateClass: AnyClass) -> Bool {
        return stateClass is FredAddsRandomButton.Type
    }
}
