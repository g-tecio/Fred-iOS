//
//  StartGame.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 4/1/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class StartGame: FredGameState {
	
	/// Timer Variables
	var pauseTimeCounter: TimeInterval = 0
	var timeForNextAction: TimeInterval = 0
	let timeOn:TimeInterval = 30/60
	let timeOff:TimeInterval = 10/60

	/// Animation
	let startAnimationSequence: [Int] = [1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 12]
	var indexStartAnimationSequence: Int = 0
	var buttonOnState = false
	var flagStartGame = false
	
	required init(game: GameScene) {
		super.init(game: game, associatedStateName: "StartGame")
	}
	
	override func didEnter(from previousState: GKState?) {
		super.didEnter(from: previousState)
		
		/// Configure timer to play start animation
		pauseTimeCounter = 0
		timeForNextAction = 20/60
		
		/// First Button to Play
		indexStartAnimationSequence = 0
		flagStartGame = false
		buttonOnState = false
	}
	
	override func willExit(to nextState: GKState) {
		super.willExit(to: nextState)
		
		/// Set game variables

		/// Reset variables to Start Game
		game.sequenceCounter = 0
		game.sequenceList.removeAll()
		game.cycles = 0
		game.score = 0
		
		/// Hide Config and Score Buttons
//		game.gameControls.configButtonSprite.removeFromParent()
//		game.gameControls.scoreButtonSprite.removeFromParent()
		game.gameControls.startSwitch.switchBar.removeFromParent()
		game.gameControls.startSwitch.labelInsideSwitchSK.text = "\(game.score)"
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		return stateClass is FredAddsRandomButton.Type
	}
	
	override func update(deltaTime: TimeInterval) {
		/// Keep track of the time since the last update.
		pauseTimeCounter += deltaTime
	
		/// If an interval of pauseInterval has passed got to FredPlayingSequence state
		if pauseTimeCounter > timeForNextAction {
			if flagStartGame {
				game.delayedReleaseButtonFunction(delayed: false, clear: false)
				game.fredGameStateMachine.enter(FredAddsRandomButton.self)
			}
			else {
				if indexStartAnimationSequence >= startAnimationSequence.count {
					/// Set flag to start game and set timer
					flagStartGame = true
					pauseTimeCounter = 0
					timeForNextAction = 30/60
					}
				else {
					if !buttonOnState {
						/// Turn On next Button from Animation Sequence
						game.pressButtonFunction(buttonId: startAnimationSequence[indexStartAnimationSequence], multiple: false)
						/// Next action will be to release button
						buttonOnState = true
						/// Set timer
						pauseTimeCounter = 0
						timeForNextAction = 6/60
					}
					else {
						/// Turn Off next Button from Animation Sequence
						game.delayedReleaseButtonFunction(delayed: false, clear: false)
						/// Next action will be to release button
						buttonOnState = false
						/// Set timer
						indexStartAnimationSequence += 1
						pauseTimeCounter = 0
						timeForNextAction = 0/60
					}
				}
			}
		}
	}
}

