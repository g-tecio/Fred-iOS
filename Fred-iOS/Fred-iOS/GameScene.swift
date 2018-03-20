//
//  GameScene.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    /// Configuration
    static let intervalBetweenCycles = 0.5
    static let intervalButtonAnimation = 0.35
    static let intervalBetweenTurns = 0.07
    static let intervalPlayerWaiting = 3.0
    
    /// State Game Machine
    var stateFredMachine: GKStateMachine!
    
    //// Keeps track of the time for use in the update method.
    var previousUpdateTime: TimeInterval = 0
    
    /// Buttons
    var fredButtons: [Button] = []
    var idButtonPlaying: Int = 0
	var isOtherButtonPlaying: Bool = false
	
    /// StartButton, Scoreboard and GameOverMessage
    var scoreboard: Scoreboard!
	var gameControls: GameControls!
    var gameOverMessage: GameOverMessage!
    
    /// Random generator
    let newValue = GKRandomDistribution(lowestValue: 1, highestValue: 12)
    
    /// Game variables
    var sequenceCounter:Int = 0
    var sequenceList:[Int] = []
    var cycles: Int = 0
    var score: Int = 0
    
    override func didMove(to view: SKView) {
        // Fred Buttons
        for button in 01...12 {
            fredButtons.append(Button.init(idButton: button, inThisScene: self))
        }
        // Scoreboard
        scoreboard = Scoreboard.init(inThisScene: self)
        // Startbutton
        gameControls = GameControls.init(inThisScene: self)
        // Game Over
        gameOverMessage = GameOverMessage.init(inThisScene: self)
        // Creates and adds states to the dispenser's state machine.
        stateFredMachine = GKStateMachine(states: [     ReadyToPlay(game: self),
                                                        FredAddsRandomButton(game: self),
                                                        FredPlayingSequence(game: self),
                                                        FredPressButton(game: self),
                                                        FredReleaseButton(game: self),
                                                        PlayerPlayingSequence(game: self),
                                                        WaitingForPlayer(game: self),
                                                        PlayerPressButton(game: self),
                                                        PlayerReleaseButton(game: self),
                                                        GameOver(game: self)
                                                    ])
        // Tells the state machine to enter the ReadyToPlay state
        stateFredMachine.enter(ReadyToPlay.self)
    }
	
	
	func pressButtonFunction(buttonId: Int) {
		idButtonPlaying = buttonId
		isOtherButtonPlaying = true
		fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].pressButtonAction )
	}
	
	func releaseButtonFunction() {
		self.isOtherButtonPlaying = false
        fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].releaseButtonAction)
    }
	
    override func update(_ currentTime: TimeInterval) {
        
        /// Set previousUpdateTime for the first time
        if previousUpdateTime == 0 {
            previousUpdateTime = currentTime
        }
        
        /// For the states that have update(deltaTime:) send the delta time
        stateFredMachine.update(deltaTime: currentTime - previousUpdateTime)
        
        /// Update previousUpdateTime to be current
        previousUpdateTime = currentTime
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let item = atPoint(location)
            
            /// Dismiss Game Over Message
             if (stateFredMachine.currentState is GameOver) {
                if (gameOverMessage.gameOverLabel === item) {
                    stateFredMachine.enter(ReadyToPlay.self)
                }
            }
            
            /// Start Play Button
            if (stateFredMachine.currentState is ReadyToPlay) {
                if (gameControls.startButtonSprite === item) || (gameControls.startLabel === item){
                    stateFredMachine.enter(FredAddsRandomButton.self)
                }
                /// Allowed to play buttons when ReadyToPlay state, no effect on Game
                else {
					if gameControls.configButtonSprite === item {
						
						// Present Config screen
//						let configScene = SKScene.init(fileNamed: "ConfigScene.sks")
						print("Configuration page")
						
					}
					else {
						for n in 1...12 {
							if (fredButtons[n-1].buttonSprite === item) && (isOtherButtonPlaying == false) {
								pressButtonFunction(buttonId: n)
							}
						}
					}
                }
            }
            
            /// Waiting for Player
            if (stateFredMachine.currentState is WaitingForPlayer) {
                for n in 1...12 {
                    if (fredButtons[n-1].buttonSprite === item) {
                        idButtonPlaying = n
                        // State change to PlayerPressButton
                        stateFredMachine.enter(PlayerPressButton.self)
                    }
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
        if (stateFredMachine.currentState is ReadyToPlay) {
            if (isOtherButtonPlaying) {
                releaseButtonFunction()
            }
        }
		
        if (stateFredMachine.currentState is PlayerPressButton) {
            releaseButtonFunction()
            stateFredMachine.enter(PlayerReleaseButton.self)
        }
    }
}
