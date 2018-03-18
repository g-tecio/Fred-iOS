//
//  Button.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import AVFoundation
import SpriteKit

let dictionaryButtonValues =   [01: (color: "Brown",       note: 261.63, xPos: 1, yPos: 4),
                                02: (color: "DarkBlue",    note: 293.66, xPos: 2, yPos: 4),
                                03: (color: "DarkGreen",   note: 329.63, xPos: 3, yPos: 4),
                                04: (color: "DarkPurple",  note: 349.23, xPos: 1, yPos: 3),
                                05: (color: "DarkRed",     note: 392.00, xPos: 2, yPos: 3),
                                06: (color: "LightBlue",   note: 440.00, xPos: 3, yPos: 3),
                                07: (color: "LightGreen",  note: 493.88, xPos: 1, yPos: 2),
                                08: (color: "LightPurple", note: 523.25, xPos: 2, yPos: 2),
                                09: (color: "LightRed",    note: 587.33, xPos: 3, yPos: 2),
                                10: (color: "Orange",      note: 659.25, xPos: 1, yPos: 1),
                                11: (color: "Pink",        note: 698.46, xPos: 2, yPos: 1),
                                12: (color: "Yellow",      note: 783.99, xPos: 3, yPos: 1)]

/// Button Struct - Where magic happens!
struct Button {
	
    /// Sprite, textures and action for button
    let buttonSprite: SKSpriteNode
    let normalTexture: SKTexture
    let lightedTexture: SKTexture
    var pressButtonAction: SKAction = SKAction.init()
    var releaseButtonAction: SKAction = SKAction.init()
	
    /// Control variables for button
    let idButton: Int
    let color: String
    let note: Double
    let xPos: Int
    let yPos: Int
	
    /// Sound for button
    let audioTonePlayerNode: AVAudioPlayerNode = AVAudioPlayerNode.init()
    let bufferWithTone: AVAudioPCMBuffer
    let bufferCapacity: AVAudioFrameCount = 512
    let amplitud = 0.12

	/// Initialization
    init (idButton: Int, inThisScene: GameScene) {
		
        /// Assign values to respective button
        self.idButton = idButton
        self.color = (dictionaryButtonValues[idButton]?.color)!
        self.note = (dictionaryButtonValues[idButton]?.note)!
        self.xPos = (dictionaryButtonValues[idButton]?.xPos)!
        self.yPos = (dictionaryButtonValues[idButton]?.yPos)!
        
        /// Assign textures to buttonSprite
        normalTexture = SKTexture(imageNamed: color + "N")
        lightedTexture = SKTexture(imageNamed: color + "H")
        buttonSprite = SKSpriteNode.init(texture: normalTexture)
        
        /// Calculates the position in the screen based on x and y location
        let tempX: Int = ((((xPos*2)-1)*Int(inThisScene.size.width*0.96/6))+Int(inThisScene.size.width*0.02))
        let tempY: Int = (((yPos*2))*Int((inThisScene.size.height)/11))
        buttonSprite.position = CGPoint(x: tempX, y: tempY )
        
        /// Resizing depending to screen size
        let resizeFactorX:CGFloat = inThisScene.size.width/375.0
        let resizeFactorY:CGFloat = inThisScene.size.height/650.0
        let originalSize = buttonSprite.size
        buttonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
        
        /// Create Tone and load into Buffer
        inThisScene.audioEngine.attach(audioTonePlayerNode)
        inThisScene.audioEngine.connect(audioTonePlayerNode,
                                        to: inThisScene.audioEngine.mainMixerNode,
                                        format: AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2))
        var theta: Double = 0
        let theta_increment = 2.0 * Double.pi * note / 44100.0
        let buffer = AVAudioPCMBuffer(pcmFormat: AVAudioFormat(standardFormatWithSampleRate: 44100.0, channels: 2)!, frameCapacity: bufferCapacity)
        var frame: UInt32 = 0
        while ( theta < (2.0 * Double.pi) ) {
            buffer?.floatChannelData![0][Int(frame)] = Float32(sin(theta) > 0 ? amplitud : -amplitud)
            buffer?.floatChannelData![1][Int(frame)] = Float32(sin(theta) > 0 ? amplitud : -amplitud)
            theta += theta_increment
            frame += 1
        }
        buffer?.frameLength = frame
        bufferWithTone = buffer!
		
		/// Set up PlayerNote
		audioTonePlayerNode.scheduleBuffer(bufferWithTone, at: nil, options: .loops, completionHandler: { })
		
		/// Actions creator
        pressButtonAction = pressActionCreator(self)
        releaseButtonAction = releaseActionCreator(self)
		
        /// Add button to scene
        inThisScene.addChild(buttonSprite)
    }
	
	/// Setup ButtonPressed Actions
    func pressActionCreator(_ thisButton: Button) -> SKAction{
		
        let lightButtonAction = SKAction.animate(with: [lightedTexture], timePerFrame: 0.0)
		
        let soundStartAction = SKAction.run {
            if thisButton.audioTonePlayerNode.isPlaying == false {
                thisButton.audioTonePlayerNode.play()
            }
        }
		
        return SKAction.sequence([lightButtonAction, soundStartAction])
    }
	
	/// Setup ButtonReleased Actions
    func releaseActionCreator(_ thisButton: Button) -> SKAction{
		
        let soundEndAction = SKAction.run {
            if thisButton.audioTonePlayerNode.isPlaying == true {
                thisButton.audioTonePlayerNode.pause()
            }
        }
		
		let normalButtonAction = SKAction.animate(with: [normalTexture], timePerFrame: 0.0)
		
        return SKAction.sequence([SKAction.wait(forDuration: 0.1), soundEndAction, normalButtonAction])
    }
}
