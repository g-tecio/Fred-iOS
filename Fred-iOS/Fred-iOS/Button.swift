//
//  Button.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

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

enum ButtonState {
    case Normal
    case Lighted
}
    
struct Button {
    // Sprite, textures and action for button
    let buttonSprite:SKSpriteNode
    let normalTexture:SKTexture
    let lightedTexture:SKTexture
    let actionLightedButton:SKAction
    // Values for button
    let idButton:Int
    let color:String
    let note:Double
    let xPos:Int
    let yPos:Int
    var state:ButtonState = .Normal

    init (idButton: Int, inThisScene:SKScene) {
        // Assign values to respective button
        self.idButton = idButton
        self.color = (dictionaryButtonValues[idButton]?.color)!
        self.note = (dictionaryButtonValues[idButton]?.note)!
        self.xPos = (dictionaryButtonValues[idButton]?.xPos)!
        self.yPos = (dictionaryButtonValues[idButton]?.yPos)!
        // Assign image and action to buttonSprite
        normalTexture = SKTexture(imageNamed: color + "N")
        lightedTexture = SKTexture(imageNamed: color + "H")
        buttonSprite = SKSpriteNode.init(texture: normalTexture)
        actionLightedButton = SKAction.animate(with: [lightedTexture, normalTexture], timePerFrame: 0.10)
        // Calculates the position in the screen based on x and y location
        let tempX: Int = (((xPos*2)-1)*Int((inThisScene.size.width-16)/6))+10
        let tempY: Int = (((yPos*2))*Int((inThisScene.size.height)/10))
        buttonSprite.position = CGPoint(x: tempX, y: tempY )
        // Resizing depending to screen size
        let resizeFactorX:CGFloat = inThisScene.size.width/380.0
        let resizeFactorY:CGFloat = inThisScene.size.height/550.0
        let originalSize = buttonSprite.size
        buttonSprite.size = CGSize(width: originalSize.width*resizeFactorX, height: originalSize.height*resizeFactorY)
        // Add button to scene
        inThisScene.addChild(buttonSprite)
    }
    
    mutating func buttonPressed () {
        buttonSprite.texture = lightedTexture
        state = ButtonState.Lighted
    }
    
    mutating func buttonReleased () {
        buttonSprite.run(actionLightedButton)
        state = ButtonState.Normal
    }
}
