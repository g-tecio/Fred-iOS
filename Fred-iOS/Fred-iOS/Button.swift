//
//  Button.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import Foundation
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

struct Button {
    // Sprite, textures and action for button
    let buttonSprite: SKSpriteNode
    let normalTexture: SKTexture
    let lightedTexture: SKTexture
    var pressButtonAction: SKAction = SKAction.init()
    var releaseButtonAction: SKAction = SKAction.init()
    // Values for button
    let idButton: Int
    let color: String
    let note: Double
    let xPos: Int
    let yPos: Int
    // Sound
    let audioTonePlayerNode: AVAudioPlayerNode = AVAudioPlayerNode.init()
    let bufferWithTone: AVAudioPCMBuffer
    let bufferCapacity: AVAudioFrameCount = 512
    let amplitud = 0.12

    init (idButton: Int, inThisScene: GameScene) {
        // Assign values to respective button
        self.idButton = idButton
        self.color = (dictionaryButtonValues[idButton]?.color)!
        self.note = (dictionaryButtonValues[idButton]?.note)!
        self.xPos = (dictionaryButtonValues[idButton]?.xPos)!
        self.yPos = (dictionaryButtonValues[idButton]?.yPos)!
        
        // Assign textures to buttonSprite
        normalTexture = SKTexture(imageNamed: color + "N")
        lightedTexture = SKTexture(imageNamed: color + "H")
        buttonSprite = SKSpriteNode.init(texture: normalTexture)
        
        // Calculates the position in the screen based on x and y location
        let tempX: Int = (((xPos*2)-1)*Int((inThisScene.size.width-16)/6))+10
        let tempY: Int = (((yPos*2))*Int((inThisScene.size.height)/10))
        buttonSprite.position = CGPoint(x: tempX, y: tempY )
        
        // Resizing depending to screen size
        let resizeFactorX:CGFloat = inThisScene.size.width/380.0
        let resizeFactorY:CGFloat = inThisScene.size.height/550.0
        let originalSize = buttonSprite.size
        buttonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
        
        // Sound  setup
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
        // Actions creator
        pressButtonAction = pressActionCreator(self)
        releaseButtonAction = releaseActionCreator(self)
        // Add button to scene
        inThisScene.addChild(buttonSprite)
    }
    
    func pressActionCreator(_ thisButton: Button) -> SKAction{
        // Setup ButtonPressed Actions
        let lightButtonAction = SKAction.animate(with: [lightedTexture], timePerFrame: 0.0)
        let soundStartAction = SKAction.run {
            if thisButton.audioTonePlayerNode.isPlaying == false {
                thisButton.audioTonePlayerNode.scheduleBuffer(thisButton.bufferWithTone, at: nil, options: .loops, completionHandler: { })
                thisButton.audioTonePlayerNode.play()
            }
        }
        return SKAction.sequence([lightButtonAction, soundStartAction])
    }
    
    func releaseActionCreator(_ thisButton: Button) -> SKAction{
        // Setup ButtonReleased Actions
        let normalButtonAction = SKAction.animate(with: [normalTexture], timePerFrame: 0.0)
        let soundEndAction = SKAction.run {
            if thisButton.audioTonePlayerNode.isPlaying == true {
                thisButton.audioTonePlayerNode.stop()
                thisButton.audioTonePlayerNode.reset()
            }
        }
        return SKAction.sequence([SKAction.wait(forDuration: 0.07), normalButtonAction, soundEndAction])
    }
    
}
