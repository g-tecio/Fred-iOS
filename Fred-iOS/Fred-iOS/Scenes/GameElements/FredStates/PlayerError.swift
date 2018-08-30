//
//  PlayerError.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 4/2/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class PlayerError: FredGameState {
	
	/// Timer Variables
	var pauseTimeCounter: TimeInterval = 0
	var timeForNextAction: TimeInterval = 0
	let timeOn:TimeInterval = 30/60
	let timeOff:TimeInterval = 10/60
	
	/// Animation
	let startAnimationSequence: [Int] = [1, 4, 7, 10, 2, 5, 8, 11, 3, 6, 9, 12]
	var indexStartAnimationSequence: Int = 0
	var buttonOnState = false
	var flagEndGame = false
	
	required init(game: GameScene) {
		super.init(game: game, associatedStateName: "PlayerError")
	}
	
	override func didEnter(from previousState: GKState?) {
		super.didEnter(from: previousState)
		
		/// Configure timer to play start animation
		pauseTimeCounter = 0
		timeForNextAction = 80/60
		
		/// Remove Effect
		game.lastPosition.x = -100
		
		/// First Button to Play
		indexStartAnimationSequence = game.fredButtons.count
		flagEndGame = false
		buttonOnState = false
		
		/// Play Wrong tone
		game.playErrorFunction()
	
	}
	
	override func willExit(to nextState: GKState) {
		super.willExit(to: nextState)
		
	}
	
	override func isValidNextState(_ stateClass: AnyClass) -> Bool {
		return stateClass is GameOver.Type
	}
	
	override func update(deltaTime: TimeInterval) {
		/// Keep track of the time since the last update.
		pauseTimeCounter += deltaTime
		
		/// If an interval of pauseInterval has passed got to FredPlayingSequence state
		if pauseTimeCounter > timeForNextAction {
			if flagEndGame {
//				game.delayedReleaseButtonFunction(delayed: false)
				game.fredGameStateMachine.enter(GameOver.self)
			}
			else {
				if indexStartAnimationSequence == 0 {
					/// Set flag to start game and set timer
					flagEndGame = true
					pauseTimeCounter = 0
					timeForNextAction = 30/60
				}
				else {
					if !buttonOnState {
						/// Turn On next Button from Animation Sequence
						game.pressButtonFunction(buttonId: startAnimationSequence[indexStartAnimationSequence-1], multiple: false)
						/// Next action will be to release button
						buttonOnState = true
						/// Set timer
						pauseTimeCounter = 0
						timeForNextAction = 6/60
					}
					else {
						/// Turn Off next Button from Animation Sequence
						game.delayedReleaseButtonFunction(delayed: false, clear: true)
						/// Remove Effect
						game.lastPosition.x = -100
						/// Next action will be to release button
						buttonOnState = false
						/// Set timer
						indexStartAnimationSequence -= 1
						pauseTimeCounter = 0
						timeForNextAction = 0/60
					}
				}
			}
		}
	}
}
