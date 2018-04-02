//
//  SwitchSK.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 4/1/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

class SwitchSK: SKNode {
	
	// MARK: Properties
	
	/// Switch Track, Bar and Label
	var switchTrack:SKSpriteNode!
	var switchBar:SKSpriteNode!
	var labelInsideSwitchSK: SKLabelNode!
	
	/// Points
	let offPoint: CGFloat = -50
	let onPoint: CGFloat = 50
	let fallPoint: CGFloat = 0
	
	/// State
	var beingSet = false
	
	/// SliderSK Value
	var valueSwitchSK: Bool = false {
		didSet {
			if valueSwitchSK {
				switchBar.position.x = onPoint
			}
			else {
				switchBar.position.x = offPoint
			}
		}
	}
	
	// MARK: Initializers
	
	init(inThisScene: GameScene, initialValue: Bool) {
		super.init()
		
		/// Values initialization
		self.valueSwitchSK = initialValue
		
		/// Label Value setup
		labelInsideSwitchSK = SKLabelNode(fontNamed: "Play")
		labelInsideSwitchSK.text = ""
		labelInsideSwitchSK.fontSize = 48
		labelInsideSwitchSK.fontColor = .white
		labelInsideSwitchSK.horizontalAlignmentMode = .center
		labelInsideSwitchSK.verticalAlignmentMode = .center
		labelInsideSwitchSK.zPosition = 2
		labelInsideSwitchSK.position = CGPoint(x: 0, y: 0)
		
		// Track
		switchTrack = SKSpriteNode.init(imageNamed: "SwitchTrack")
		switchTrack.position = CGPoint(x: 0, y: 0)
		switchTrack.zPosition = 1
		
		/// Switch Element
		switchBar = SKSpriteNode.init(imageNamed: "Switch")
		switchBar.zPosition = 3
		switchBar.position = CGPoint(x: -50, y: 0)
		
		// Add to SliderSK Node
		addChild(switchTrack)
		addChild(labelInsideSwitchSK)
		addChild(switchBar)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func movingSwitch(point: CGFloat) {
		if point > onPoint {
			switchBar.position.x = onPoint
		}
		else {
			if point < offPoint {
				switchBar.position.x = offPoint
			}
			else {
				switchBar.position.x = point
			}
		}
	}
	
	func setFromPosition() -> Bool {
		if switchBar.position.x > fallPoint {
			valueSwitchSK = true
			return true
		}
		else {
			valueSwitchSK = false
			return false
		}
	}
	
}
