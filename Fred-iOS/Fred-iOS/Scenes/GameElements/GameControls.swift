//
//  GameControls.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/19/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit
import AVFoundation

struct GameControls {
	
	/// Start Switch
	var startSwitch: SwitchSK!
	
	/// Error
	var playErrorSoundAction: SKAction = SKAction.init()

	/// Configuration Button
	let configButtonSprite: SKSpriteNode
	let scoreButtonSprite: SKSpriteNode
	
	/// Sound for button
	let audioTonePlayerNode: AVAudioPlayerNode = AVAudioPlayerNode.init()
	let bufferCapacity: AVAudioFrameCount = 512
	let bufferWithTone: AVAudioPCMBuffer!
	let amplitud = 0.12
	let note: Double = 140.00
	
	/// Feedback
	var feedbackGenerator : UIImpactFeedbackGenerator
	
	/// Initialization
	init(inThisScene: GameScene) {
		
		/// Create Tone and load into Buffer
		var theta: Double = 0
		let theta_increment = 2.0 * Double.pi * note / 44100.0
		bufferWithTone = AVAudioPCMBuffer(pcmFormat: AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)!, frameCapacity: bufferCapacity)
		var frame: UInt32 = 0
		while ( theta < (2.0 * Double.pi) ) {
			bufferWithTone.floatChannelData![0][Int(frame)] = Float32(sin(theta) > 0 ? amplitud : -amplitud)
			bufferWithTone.floatChannelData![1][Int(frame)] = Float32(sin(theta) > 0 ? amplitud : -amplitud)
			theta += theta_increment
			frame += 1
		}
		bufferWithTone.frameLength = frame
		
		/// Set up Tone PlayerNode
		inThisScene.audioEngine.attach(audioTonePlayerNode)
		inThisScene.audioEngine.connect(audioTonePlayerNode,
										to: inThisScene.audioEngine.mainMixerNode,
										format: AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2))
		audioTonePlayerNode.scheduleBuffer(bufferWithTone, at: nil, options: .loops, completionHandler: { })
		
		/// Start Switch
		startSwitch = SwitchSK.init(inThisScene: inThisScene, initialValue: false)
		startSwitch.name = "Start Switch"
		startSwitch.position = CGPoint(x: inThisScene.size.width/2, y: (inThisScene.size.height*55/60))
		startSwitch.zPosition = 3
		
		/// Configuration Button
		configButtonSprite = SKSpriteNode.init(imageNamed: "ConfigScene")
		configButtonSprite.name = "Config Button"
		configButtonSprite.position = CGPoint(x: inThisScene.size.width*6/50, y: (inThisScene.size.height*55/60))
		configButtonSprite.zPosition = 3

		/// HighScore Button
		scoreButtonSprite = SKSpriteNode.init(imageNamed: "ScoresScene")
		scoreButtonSprite.name = "Score Button"
		scoreButtonSprite.position = CGPoint(x: inThisScene.size.width*44/50, y: (inThisScene.size.height*55/60))
		configButtonSprite.zPosition = 3
		
		/// Feedback
		feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
		feedbackGenerator.prepare()
		
		// Error Sound
		playErrorSoundAction = playErrorSoundCreator(thisControl: self)
	}
	
	func playErrorSoundCreator(thisControl: GameControls) ->SKAction {
		
		let soundStartAction = SKAction.run {
			if !thisControl.audioTonePlayerNode.isPlaying {
				thisControl.audioTonePlayerNode.play()
				thisControl.feedbackGenerator.impactOccurred()
			}
		}
		
		/// Action to end Sound
		let soundEndAction = SKAction.run {
			if thisControl.audioTonePlayerNode.isPlaying {
				thisControl.audioTonePlayerNode.pause()
			}
		}
		
		/// Return action for Release
		return SKAction.sequence( [soundStartAction, SKAction.wait(forDuration: 1), soundEndAction] )
	}
}
