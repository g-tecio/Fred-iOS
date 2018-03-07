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
    
    var fredButtons : [Button] = []
    var toneGenerator = ToneGenerator()
    
    override func didMove(to view: SKView) {
        // Create Fred Buttons
        fredButtons.append(Button.init(idButton: 01, inThisScene: self))
        fredButtons.append(Button.init(idButton: 02, inThisScene: self))
        fredButtons.append(Button.init(idButton: 03, inThisScene: self))
        fredButtons.append(Button.init(idButton: 04, inThisScene: self))
        fredButtons.append(Button.init(idButton: 05, inThisScene: self))
        fredButtons.append(Button.init(idButton: 06, inThisScene: self))
        fredButtons.append(Button.init(idButton: 07, inThisScene: self))
        fredButtons.append(Button.init(idButton: 08, inThisScene: self))
        fredButtons.append(Button.init(idButton: 09, inThisScene: self))
        fredButtons.append(Button.init(idButton: 10, inThisScene: self))
        fredButtons.append(Button.init(idButton: 11, inThisScene: self))
        fredButtons.append(Button.init(idButton: 12, inThisScene: self))
        // Setup Audio
        toneGenerator.setupAudio()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let item = self.atPoint(location)
            for n in 1...12 {
                if fredButtons[n-1].buttonSprite == item {
                    fredButtons[n-1].buttonPressed()
                    toneGenerator.startPlaying(fredButtons[n-1].note)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for n in 1...12 {
            if fredButtons[n-1].state == ButtonState.Lighted {
                fredButtons[n-1].buttonReleased()
                toneGenerator.stopPlaying()
            }
        }
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
