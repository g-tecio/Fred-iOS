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
	
	// MARK: Game Properties

		/// State Game Machine
		var fredGameStateMachine: GKStateMachine!
	
		/// Keeps track of the time for use in the update method.
		var previousUpdateTime: TimeInterval = 0
	
		/// Buttons
		var fredButtons: [Button] = []
		var idButtonPlaying: Int = 0
		var isAButtonPlaying: Bool = false
	
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
	
		/// Effect
		var traceEffect: SKEmitterNode!
		var movingNode : SKNode!
		var lastPosition: CGPoint = CGPoint.init(x: -100, y: 0)
		var newPosition: CGPoint = CGPoint.init(x: 0, y: 0)
	
	// MARK: Game Initializer
	
		/// Custom Initializer
		init(sceneSize: CGSize, referenceGVC: GameViewController) {
			
			/// Set reference of GameViewControl
			gameViewController = referenceGVC
			
			/// Create scene from code
			super.init(size: sceneSize)
			
			/// Create FredButtons, Scoreboard, Startbutton and GameOver
			for button in 01...12 {
				fredButtons.append(Button.init(idButton: button, inThisScene: self))
			}
			scoreboard = Scoreboard.init(inThisScene: self)
			gameControls = GameControls.init(inThisScene: self)
			gameOverMessage = GameOverMessage.init(inThisScene: self)
			
			/// Trace and touch effects
			traceEffect = SKEmitterNode.init(fileNamed: "Trace.sks")
			traceEffect.targetNode = self
			traceEffect.name = "TouchEffectNode"
			
			self.movingNode = SKNode.init()
			if let movingNode = self.movingNode {
				movingNode.name =  "TouchEffectNode"
				movingNode.addChild(traceEffect)
				movingNode.zPosition = 21
			}
			
			/// Creates FredGameStateMachineand with States
			fredGameStateMachine = GKStateMachine(states: [ ReadyToPlay(game: self),
															StartGame(game: self),
															FredAddsRandomButton(game: self),
															FredPlayingSequence(game: self),
															FredPressButton(game: self),
															FredReleaseButton(game: self),
															PlayerPlayingSequence(game: self),
															WaitingForPlayer(game: self),
															PlayerPressButton(game: self),
															PlayerReleaseButton(game: self),
															PlayerError(game: self),
															GameOver(game: self) ] )
			fredGameStateMachine.enter(ReadyToPlay.self)
			
			/// Load scene
			if let skView = gameViewController.view as! SKView? {
				self.size = skView.bounds.size
				self.scaleMode = .aspectFill
				
				// TODO: Comment or remove before release to App Store
				skView.ignoresSiblingOrder = true
				skView.showsFPS = true
				skView.showsNodeCount = true
			}
		}
	
		/// Included because is a requisite if a custom Init is used
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	
	// MARK: Custom Methods
	
	func playErrorFunction() {
		gameControls.errorSprite.run( gameControls.playErrorSoundAction )
	}
	
		/// Press Button
		func pressButtonFunction(buttonId: Int, multiple: Bool) {
			
			idButtonPlaying = buttonId
			
			if fredButtons[idButtonPlaying-1].buttonSprite.hasActions() {
				fredButtons[idButtonPlaying-1].buttonSprite.removeAllActions()
			}
			
			if !isAButtonPlaying || multiple {
				/// ButtonAction
				isAButtonPlaying = true
				fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].pressButtonAction )
				/// Effect
				newPosition = fredButtons[idButtonPlaying-1].buttonSprite.position
				if lastPosition.x != CGFloat(-100) {
					if let m = self.movingNode?.copy() as! SKNode? {
						m.position = lastPosition
						self.addChild(m)
						m.run(SKAction.move(to: newPosition, duration: 0.3))
					}
				}
			}
		}
	
		/// Delayed Release Button
	func delayedReleaseButtonFunction(delayed: Bool, clear: Bool) {
			
//			for n in 1...12 {
//				if fredButtons[n-1].buttonSprite.hasActions() {
//					fredButtons[n-1].buttonSprite.removeAllActions()
//				}
				if (delayed && GameData.shared.framesDelayedRelease > 0) {
					/// ButtonAction
					fredButtons[idButtonPlaying-1].buttonSprite.run( SKAction.sequence([SKAction.wait(forDuration: Double(GameData.shared.framesDelayedRelease)/60.0), fredButtons[idButtonPlaying-1].immediateReleaseButtonAction]))
				}
				else {
					if !clear {
						fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].immediateReleaseButtonAction )
					}
					else {
						fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].clearOnReleaseButtonAction )
					}
				}
				/// Effect
				lastPosition = newPosition
				for node in self.children {
					if node.name == "TouchEffectNode" {
						node.run(SKAction.sequence([ SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
					}
				}
//			}
			self.isAButtonPlaying = false
		}
	
	// MARK: Override Methods
	
		/// Present FredGameElements to the Scene
		override func didMove(to view: SKView) {
			
			/// Present Buttons
			for button in 01...12 {
				self.addChild( fredButtons[button-1].buttonSprite )
			}
			/// Present Scoreboard, GameControls and GameOverMessage
//			self.addChild(scoreboard.score)
			self.addChild(gameControls.startSwitch)
			self.addChild(gameControls.configButtonSprite)
			self.addChild(gameControls.scoreButtonSprite)
			self.addChild(gameControls.errorSprite)
			self.addChild(gameOverMessage.gameOverLabel)
		}
	
		/// Remove elements When other scene will be presented Unload Scene
		override func willMove(from view: SKView) {
			
			/// Remove all elements fpr
			self.removeAllChildren()
		}
	
		/// Update runs every frame (~60 times each second)
		override func update(_ currentTime: TimeInterval) {
			
			/// Set previousUpdateTime for the first time
			if previousUpdateTime == 0 {
				previousUpdateTime = currentTime
			}
			
			/// For the states that have update(deltaTime:) send the delta time
			fredGameStateMachine.update(deltaTime: currentTime - previousUpdateTime)
			
			/// Update previousUpdateTime to be current
			previousUpdateTime = currentTime
		}

		/// Touch Down
		override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
						
			for touch in touches {
				let location = touch.location(in: self)
				let item = atPoint(location)
				
				/// Start Play or Config Scene or Play Button
				if (fredGameStateMachine.currentState is ReadyToPlay) {
					/// Start Game
					if gameControls.startSwitch.switchBar === item {
						gameControls.startSwitch.beingSet = true
					}
					else {
						/// Config Scene
						if gameControls.configButtonSprite === item {
							gameViewController.sceneStateMachine.enter(ConfigSceneState.self)
						}
						else {
							/// Config Scene
							if gameControls.scoreButtonSprite === item {
								gameViewController.sceneStateMachine.enter(ScoresSceneState.self)
							}
//							else {
//								/// Play buttons when ReadyToPlay state, no effect on Game
//								for n in 1...12 {
//									if (fredButtons[n-1].buttonSprite === item) {
//										pressButtonFunction(buttonId: n, multiple: false)
//									}
//								}
//							}
						}
					}
				}
				
				/// Waiting for Player
				if (fredGameStateMachine.currentState is WaitingForPlayer) {
					for n in 1...12 {
						if (fredButtons[n-1].buttonSprite === item) {
							idButtonPlaying = n
							/// State change to PlayerPressButton
							fredGameStateMachine.enter(PlayerPressButton.self)
						}
					}
				}
				
				/// Dismiss Game Over Message
				if (fredGameStateMachine.currentState is GameOver) {
					if (gameOverMessage.gameOverLabel === item) {
						fredGameStateMachine.enter(ReadyToPlay.self)
					}
				}
				
			}
		}
	
		/// Touch Up
		override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
			
			/// On ReadyToPlay state (aka Practice mode)
			if (fredGameStateMachine.currentState is ReadyToPlay) {
				
				// Start Game if startSwitch is set to true
				if gameControls.startSwitch.beingSet {
					gameControls.startSwitch.beingSet = false
					if gameControls.startSwitch.setFromPosition() {
						fredGameStateMachine.enter(StartGame.self)
					}
				}
				// Release Button on Pratice mode
				if isAButtonPlaying {
					delayedReleaseButtonFunction(delayed: true, clear: false)
				}
			}
			
			/// Release Button Action when on game mode
			if (fredGameStateMachine.currentState is PlayerPressButton) {
				fredGameStateMachine.enter(PlayerReleaseButton.self)
			}
		}
	
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		let pos = touches.first!.location(in: self)
		
		/// StartSwitch being set
		if gameControls.startSwitch.beingSet {
			gameControls.startSwitch.movingSwitch(point: convert(pos, to: gameControls.startSwitch).x)
		}
		
	}
	
}
