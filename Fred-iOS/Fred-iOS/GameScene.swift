//
//  GameScene.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/6/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import Foundation
import AVFoundation
import SpriteKit

class GameScene: SKScene {
    
    // Buttons
    var fredButtons : [Button] = []
    var idButtonPlaying: Int = 0
    var isSoundEnding = false

    override func didMove(to view: SKView) {
        // Create Fred Buttons
        for button in 01...12 {
            fredButtons.append(Button.init(idButton: button, inThisScene: self))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            let item = self.atPoint(location)
            for n in 1...12 {
                if (fredButtons[n-1].buttonSprite == item) && (idButtonPlaying == 0) {
                    idButtonPlaying = n
                    fredButtons[n-1].buttonSprite.run(fredButtons[n-1].pressButtonAction)
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if idButtonPlaying != 0 {
            if isSoundEnding == false {
                isSoundEnding = true
                fredButtons[idButtonPlaying-1].buttonSprite.run(fredButtons[idButtonPlaying-1].releaseButtonAction, completion: {
                    self.idButtonPlaying = 0
                    self.isSoundEnding = false
                })
            }
        }
    }
 
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
