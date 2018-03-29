//
//  Button.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import AVFoundation
import SpriteKit

let dictionaryButtonValues =   [01: (color: "LightRed",       note: 261.63, xPos: 1, yPos: 4),
                                02: (color: "Pink",    note: 293.66, xPos: 2, yPos: 4),
                                03: (color: "LightGreen",   note: 329.63, xPos: 3, yPos: 4),
                                04: (color: "LightYellow",      note: 349.23, xPos: 1, yPos: 3),
                                05: (color: "LightBlue",     note: 392.00, xPos: 2, yPos: 3),
                                06: (color: "Orange",   note: 440.00, xPos: 3, yPos: 3),
                                07: (color: "DarkGreen",  note: 493.88, xPos: 1, yPos: 2),
                                08: (color: "Rose", note: 523.25, xPos: 2, yPos: 2),
                                09: (color: "Olive",    note: 587.33, xPos: 3, yPos: 2),
                                10: (color: "BlueGray",      note: 659.25, xPos: 1, yPos: 1),
                                11: (color: "DarkGreen",        note: 698.46, xPos: 2, yPos: 1),
                                12: (color: "DarkBlue", note: 783.99, xPos: 3, yPos: 1)]

// Button Struct - Where magic happens!
struct Button {
	
    /// Sprite, textures and action for button
    let buttonSprite: SKSpriteNode
    let normalTexture: SKTexture
    let lightedTexture: SKTexture
    var pressButtonAction: SKAction = SKAction.init()
	var immediateReleaseButtonAction: SKAction = SKAction.init()
	
    /// Control variables for button
    let idButton: Int
    let color: String
    let note: Double
    let xPos: Int
    let yPos: Int
	
    /// Sound for button
    let audioTonePlayerNode: AVAudioPlayerNode = AVAudioPlayerNode.init()
    let bufferCapacity: AVAudioFrameCount = 512
	let bufferWithTone: AVAudioPCMBuffer!
    let amplitud = 0.12

	/// Initialization
    init (idButton: Int, inThisScene: GameScene) {
		
        /// Assign values to respective button
        self.idButton = idButton
        self.color = (dictionaryButtonValues[idButton]?.color)!
        self.note = (dictionaryButtonValues[idButton]?.note)!
        self.xPos = (dictionaryButtonValues[idButton]?.xPos)!
        self.yPos = (dictionaryButtonValues[idButton]?.yPos)!
        
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
		
		/// Assign textures to buttonSprite
		normalTexture = SKTexture(imageNamed: color + "N")
		lightedTexture = SKTexture(imageNamed: color + "L")
		buttonSprite = SKSpriteNode.init(texture: normalTexture)
		
		/// Calculates the position in the screen based on x and y location
		let tempX: Int = ((((xPos*2)-1)*Int(inThisScene.size.width*0.96/6))+Int(inThisScene.size.width*0.02))
		let tempY: Int = (((yPos*2))*Int((inThisScene.size.height)/10))
		buttonSprite.position = CGPoint(x: tempX, y: tempY )
		
		/// Resizing depending to screen size
		let resizeFactorX:CGFloat = inThisScene.size.width/375.0
		let resizeFactorY:CGFloat = inThisScene.size.height/650.0
		let originalSize = buttonSprite.size
		buttonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
		
		/// Actions creator
		pressButtonAction = pressActionCreator(thisButton: self)
		immediateReleaseButtonAction = immediateReleaseActionCreator(thisButton: self)
    }
	
	/// ButtonPressed Action
    func pressActionCreator(thisButton: Button) -> SKAction{
		
		/// Action to turn on light in button
		let lightButtonAction = SKAction.animate(with: [lightedTexture], timePerFrame: 0.0)
		
		/// Action to start Sound
        let soundStartAction = SKAction.run {
            if !thisButton.audioTonePlayerNode.isPlaying {
                thisButton.audioTonePlayerNode.play()
            }
        }
		
		/// Return Action for Press
        return SKAction.group([lightButtonAction, soundStartAction])
    }
	
	// Immediate ButtonReleased Action
	func immediateReleaseActionCreator(thisButton: Button) -> SKAction{
		
		/// Action to turn off light in button
		let normalButtonAction = SKAction.animate(with: [normalTexture], timePerFrame: 0.0)
		
		/// Action to end Sound
		let soundEndAction = SKAction.run {
			if thisButton.audioTonePlayerNode.isPlaying {
				thisButton.audioTonePlayerNode.pause()
			}
		}
		
		/// Return action for Release
		return SKAction.group( [soundEndAction, normalButtonAction] )
	}
}
