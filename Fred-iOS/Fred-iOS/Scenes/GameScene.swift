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
		var spinnyNode : SKShapeNode!
		var movingNode : SKShapeNode!
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
			
			let w = (self.size.width + self.size.height) * 0.03
			
			self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.2)
			if let spinnyNode = self.spinnyNode {
				spinnyNode.lineWidth = 2.5
				spinnyNode.name =  "TouchEffectNode"
				spinnyNode.zPosition = 20
				spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.3)))
			}
			
			self.movingNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.2)
			if let movingNode = self.movingNode {
				movingNode.lineWidth = 2.5
				movingNode.name =  "TouchEffectNode"
				movingNode.addChild(traceEffect)
				movingNode.zPosition = 21
//				movingNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 0.25)))
//				movingNode.run(SKAction.sequence([ 	SKAction.wait(forDuration: 0.5),
//													   SKAction.fadeOut(withDuration: 0.3),
//													   SKAction.removeFromParent()]))
			}
			
			/// Creates FredGameStateMachineand with States
			fredGameStateMachine = GKStateMachine(states: [ ReadyToPlay(game: self),
															FredAddsRandomButton(game: self),
															FredPlayingSequence(game: self),
															FredPressButton(game: self),
															FredReleaseButton(game: self),
															PlayerPlayingSequence(game: self),
															WaitingForPlayer(game: self),
															PlayerPressButton(game: self),
															PlayerReleaseButton(game: self),
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
	
		/// Press Button
		func pressButtonFunction(buttonId: Int) {
			
			idButtonPlaying = buttonId
			
			if fredButtons[idButtonPlaying-1].buttonSprite.hasActions() {
				fredButtons[idButtonPlaying-1].buttonSprite.removeAllActions()
			}
			
			if !isAButtonPlaying {
				/// ButtonAction
				isAButtonPlaying = true
				fredButtons[idButtonPlaying-1].buttonSprite.run( fredButtons[idButtonPlaying-1].pressButtonAction )
				/// Effect
				newPosition = fredButtons[idButtonPlaying-1].buttonSprite.position
				if lastPosition.x != CGFloat(-100) {
					if let m = self.movingNode?.copy() as! SKShapeNode? {
						m.position = lastPosition
						m.strokeColor = SKColor.blue
						self.addChild(m)
						m.run(SKAction.move(to: newPosition, duration: 0.3))
					}
				}
//				if let s = self.spinnyNode?.copy() as! SKShapeNode? {
//					s.position = newPosition
//					s.strokeColor = SKColor.red
//					self.addChild(s)
//				}
			}
		}
	
		/// Delayed Release Button
		func delayedReleaseButtonFunction(delayed: Bool) {
			
			for n in 1...12 {
				if fredButtons[n-1].buttonSprite.hasActions() {
					fredButtons[n-1].buttonSprite.removeAllActions()
				}
				if (idButtonPlaying == n && delayed && GameData.shared.framesDelayedRelease > 0) {
					/// ButtonAction
					fredButtons[n-1].buttonSprite.run( SKAction.sequence([SKAction.wait(forDuration: Double(GameData.shared.framesDelayedRelease)/60.0), fredButtons[n-1].immediateReleaseButtonAction]))
				}
				else {
					fredButtons[n-1].buttonSprite.run( fredButtons[n-1].immediateReleaseButtonAction )
				}
				/// Effect
				lastPosition = newPosition
				for node in self.children {
					if node.name == "TouchEffectNode" {
						node.run(SKAction.sequence([ SKAction.fadeOut(withDuration: 0.2), SKAction.removeFromParent()]))
					}
				}
			}
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
//			self.addChild(scoreboard.backgroundScoreboardSprite)
			self.addChild(scoreboard.score)
			self.addChild(gameControls.startButtonSprite)
			self.addChild(gameControls.configButtonSprite)
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
					if (gameControls.startButtonSprite === item) || (gameControls.startLabel === item){
						fredGameStateMachine.enter(FredAddsRandomButton.self)
					}
					else {
						/// Config Scene
						if gameControls.configButtonSprite === item {
							gameViewController.sceneStateMachine.enter(ConfigSceneState.self)
						}
						else {
							/// Play buttons when ReadyToPlay state, no effect on Game
							for n in 1...12 {
								if (fredButtons[n-1].buttonSprite === item) {
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
			
			/// Release Button Action when on practice mode
			if (fredGameStateMachine.currentState is ReadyToPlay) {
				delayedReleaseButtonFunction(delayed: true)
			}
			
			/// Release Button Action when on game mode
			if (fredGameStateMachine.currentState is PlayerPressButton) {
				fredGameStateMachine.enter(PlayerReleaseButton.self)
			}
		}
	
}
