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
    var fredGameStateMachine: GKStateMachine!
    
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
	
	/// GameViewControl setup as reference to handle SceneStates
	var gameViewController: GameViewController
	
	init(sceneSize: CGSize, referenceGVC: GameViewController) {
		gameViewController = referenceGVC
		super.init(size: sceneSize)
		
		loadFredGameElements()
		
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	/// Load Elements of Fred Game
	func loadFredGameElements() {
		
		/// Create FredButtons, Scoreboard, Startbutton and GameOver
		for button in 01...12 {
			fredButtons.append(Button.init(idButton: button, inThisScene: self))
		}
		scoreboard = Scoreboard.init(inThisScene: self)
		gameControls = GameControls.init(inThisScene: self)
		gameOverMessage = GameOverMessage.init(inThisScene: self)
		
		/// Creates FredGameStateMachineand adds States
		fredGameStateMachine = GKStateMachine(states: [ ReadyToPlay(game: self),
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
		fredGameStateMachine.enter(ReadyToPlay.self)
	}
	
	/// Present FredGameElements to the Scene
    override func didMove(to view: SKView) {
		
		// Present Buttons
		for button in 01...12 {
			self.addChild( fredButtons[button-1].buttonSprite )
		}
		// Present Scoreboard
		self.addChild(scoreboard.backgroundScoreboardSprite)
		// Present GameControls
		self.addChild(gameControls.startButtonSprite)
		self.addChild(gameControls.configButtonSprite)
		// Present GameOverMessage
		self.addChild(gameOverMessage.gameOverLabel)
		
    }
	
	// Unload Scene
	override func willMove(from view: SKView) {

		self.removeAllChildren()
	}
	
	/// Press Button
	func pressButtonFunction(buttonId: Int) {
		idButtonPlaying = buttonId
		isOtherButtonPlaying = true
		fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].pressButtonAction )
	}
	
	/// Release Button
	func releaseButtonFunction() {
		self.isOtherButtonPlaying = false
        fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].releaseButtonAction )
    }
	
	/// Update runs every frame (~60 times each second)
    override func update(_ currentTime: TimeInterval) {
        
        // Set previousUpdateTime for the first time
        if previousUpdateTime == 0 {
            previousUpdateTime = currentTime
        }
        
        // For the states that have update(deltaTime:) send the delta time
        fredGameStateMachine.update(deltaTime: currentTime - previousUpdateTime)
        
        // Update previousUpdateTime to be current
        previousUpdateTime = currentTime
    }

	/// Touch Down
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let item = atPoint(location)
            
            /// Dismiss Game Over Message
             if (fredGameStateMachine.currentState is GameOver) {
                if (gameOverMessage.gameOverLabel === item) {
                    fredGameStateMachine.enter(ReadyToPlay.self)
                }
            }
            
            /// Start Play or Config Scene or Play Button
            if (fredGameStateMachine.currentState is ReadyToPlay) {
				// Start Game
                if (gameControls.startButtonSprite === item) || (gameControls.startLabel === item){
                    fredGameStateMachine.enter(FredAddsRandomButton.self)
                }
                else {
					// Config Scene
					if gameControls.configButtonSprite === item {
						gameViewController.sceneStateMachine.enter(ConfigSceneState.self)
					}
					// Play buttons when ReadyToPlay state, no effect on Game
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
            if (fredGameStateMachine.currentState is WaitingForPlayer) {
                for n in 1...12 {
                    if (fredButtons[n-1].buttonSprite === item) {
                        idButtonPlaying = n
                        // State change to PlayerPressButton
                        fredGameStateMachine.enter(PlayerPressButton.self)
                    }
                }
            }
        }
    }
	
	/// Touch Up
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		
        if (fredGameStateMachine.currentState is ReadyToPlay) {
            if (isOtherButtonPlaying) {
                releaseButtonFunction()
            }
        }
		
        if (fredGameStateMachine.currentState is PlayerPressButton) {
            releaseButtonFunction()
            fredGameStateMachine.enter(PlayerReleaseButton.self)
        }
    }
}
