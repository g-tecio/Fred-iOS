//
//  SliderSK.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/24/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

class SliderSK: SKNode {
	
	/// SliderSK element
	var sliderSKElement: SKShapeNode!
	
	/// SliderSK LabelTitle and LabelValue
	var labelTitleSliderSK: SKLabelNode!
	var labelValueSliderSK: SKLabelNode!
	
	
	/// SliderSK Background
	var backgroundSliderSK: SKSpriteNode!
	
	/// SliderSK Value
	var valueSliderSK: Int = 0 {
		didSet {
			sliderSKElement.position = CGPoint(x: (-CGFloat(backgroundSliderSK.size.width)/2.0)+CGFloat(backgroundSliderSK.size.width)/CGFloat(maxSliderSK-minSliderSK)*CGFloat(valueSliderSK), y: CGFloat(0.0))
			labelValueSliderSK.text = "\(valueSliderSK)"
		}
	}
	
	/// SliderSK Max and Min
	var minSliderSK: Int = 0
	var maxSliderSK: Int = 60

	/// SliderSK Width
	var widthSliderSK: CGFloat {
		return backgroundSliderSK.frame.size.width
	}
	
	// SliderSK Height
	var heightSliderSK: CGFloat {
		return sliderSKElement.frame.size.height
	}
	
	private(set) var actionClicked: Selector?
	private(set) var targetClicked: AnyObject?
	
	init(width: Int, height: Int, text: String) {
		
		super.init()
		
		/// Label Title setup
		labelTitleSliderSK = SKLabelNode(fontNamed: "Helvetica Bold")
		labelTitleSliderSK.text = text
		labelTitleSliderSK.fontSize = 36
		labelTitleSliderSK.fontColor = .yellow
		labelTitleSliderSK.horizontalAlignmentMode = .center
		labelTitleSliderSK.verticalAlignmentMode = .bottom
		labelTitleSliderSK.position = CGPoint(x: CGFloat(0.0), y: CGFloat(height)*2.0)
		
		/// Label Value setup
		labelValueSliderSK = SKLabelNode(fontNamed: "Helvetica Bold")
		labelValueSliderSK.text = "\(valueSliderSK)"
		labelValueSliderSK.fontSize = 36
		labelValueSliderSK.fontColor = .white
		labelValueSliderSK.horizontalAlignmentMode = .center
		labelValueSliderSK.verticalAlignmentMode = .top
		labelValueSliderSK.position = CGPoint(x: CGFloat(0.0), y: CGFloat(-height)*2.0)
		
		// Background
		backgroundSliderSK = SKSpriteNode(color: .cyan, size: CGSize(width: CGFloat(width), height: CGFloat(6)))
		backgroundSliderSK.position = CGPoint(x: CGFloat(0.0), y: CGFloat(0.0))
		
		/// Slider
		sliderSKElement = SKShapeNode(circleOfRadius: CGFloat( height ) )
		sliderSKElement.fillColor = .white
		sliderSKElement.position = CGPoint(x: CGFloat(-width)/2.0 + sliderSKElement.position.x , y: CGFloat(0.0))

		
		// Add to SliderSK Node
		addChild(labelTitleSliderSK)
		addChild(labelValueSliderSK)
		addChild(backgroundSliderSK)
		addChild(sliderSKElement)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		/// Background Color
		backgroundSliderSK.color = .gray

		let x = touches.first!.location(in: self).x - backgroundSliderSK.position.x
		print(x)
		let pos = max(fmin(x, widthSliderSK), 0.0)
		print(pos)
		
		sliderSKElement!.position = CGPoint(x: CGFloat(backgroundSliderSK.position.x + pos), y: CGFloat(0.0))
		valueSliderSK = Int(pos / widthSliderSK)
		_ = targetClicked!.perform(actionClicked, with: self)
	}

}
