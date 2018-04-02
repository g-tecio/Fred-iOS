//
//  SliderSK.swift
//  Fred-iOS
//
//  Created by Fernando Vazquez on 3/24/18.
//  Copyright © 2018 Cartwheel Galaxy. All rights reserved.
//

import SpriteKit

class SliderSK: SKNode {
	
	// MARK: Properties
	
		/// Constants - modify by code if adjustments required
		let heightPoints: CGFloat = 10.0
		let lineThickness: CGFloat = 2.0
	
		/// SliderSK element and backgroundLine
		var sliderSKElement: SKShapeNode!
		var backgroundSliderSK: SKSpriteNode!
	
		/// SliderSK LabelTitle and LabelValue
		var labelTitleSliderSK: SKLabelNode!
		var labelValueSliderSK: SKLabelNode!
	
		/// Slider Status
		var beingChanged: Bool = false
	
		/// Values
		var minValue: Int = 0
		var maxValue: Int = 60
		var rangeValue: Int = 60
	
		/// Points
		var widthPoints: CGFloat = 380.0
		var minPoint: CGFloat = 38.0
		var maxPoint: CGFloat = 342.0
		var rangePoint: CGFloat = 304.0
	
		/// SliderSK Value
		var valueSliderSK: Int = 0 {
			didSet {
				valueSliderSK = valueSliderSK>maxValue ? maxValue : valueSliderSK
				valueSliderSK = valueSliderSK<minValue ? minValue : valueSliderSK
				
				sliderSKElement.position = CGPoint(x: pointFromValue(value: valueSliderSK), y: CGFloat(0.0))
				labelValueSliderSK.text = "\(valueSliderSK)"
			}
		}

	// MARK: Initializers
	
		init(inThisScene: ConfigScene, initialValue: Int, minValue: Int, maxValue: Int, title: String, postionY: CGFloat) {
			super.init()
			
			/// Values initialization
			self.minValue = minValue
			self.maxValue = maxValue
			self.rangeValue = maxValue-minValue
			self.valueSliderSK = initialValue
			
			/// Points
			self.widthPoints = inThisScene.size.width*0.8
			self.minPoint = inThisScene.size.width*0.1
			self.maxPoint = inThisScene.size.width*0.9
			self.rangePoint = maxPoint-minPoint
			
			// Position on Screen for SlideSK
			self.position.y = postionY
			self.name = title
			
			/// Label Title setup
			labelTitleSliderSK = SKLabelNode(fontNamed: "Helvetica Bold")
			labelTitleSliderSK.text = title
			labelTitleSliderSK.fontSize = 18
			labelTitleSliderSK.fontColor = .yellow
			labelTitleSliderSK.horizontalAlignmentMode = .center
			labelTitleSliderSK.verticalAlignmentMode = .bottom
			labelTitleSliderSK.zPosition = 1
			labelTitleSliderSK.position = CGPoint(x: inThisScene.size.width/2, y: heightPoints*2.0)
			labelTitleSliderSK.name = title
			
			/// Label Value setup
			labelValueSliderSK = SKLabelNode(fontNamed: "Helvetica Bold")
			labelValueSliderSK.text = "\(valueSliderSK)"
			labelValueSliderSK.fontSize = 18
			labelValueSliderSK.fontColor = .white
			labelValueSliderSK.horizontalAlignmentMode = .center
			labelValueSliderSK.verticalAlignmentMode = .top
			labelValueSliderSK.zPosition = 1
			labelValueSliderSK.position = CGPoint(x: inThisScene.size.width/2, y: -heightPoints*2.0)
			labelValueSliderSK.name = title
			
			// Background
			backgroundSliderSK = SKSpriteNode(color: .cyan, size: CGSize(width: rangePoint, height: lineThickness))
			backgroundSliderSK.position = CGPoint(x:inThisScene.size.width/2, y: CGFloat(0.0))
			backgroundSliderSK.zPosition = 1
			backgroundSliderSK.name = title
			
			/// Slider
			sliderSKElement = SKShapeNode(circleOfRadius: heightPoints)
			sliderSKElement.fillColor = .white
			sliderSKElement.zPosition = 2
			sliderSKElement.position = CGPoint(x: pointFromValue(value: valueSliderSK), y: CGFloat(0.0))
			sliderSKElement.name = title

			// Add to SliderSK Node
			addChild(labelTitleSliderSK)
			addChild(labelValueSliderSK)
			addChild(backgroundSliderSK)
			addChild(sliderSKElement)
		}
	
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
	
	// MARK: Custom Methods
	
		func pointFromValue(value: Int) -> CGFloat {
			let point = (CGFloat(value)*rangePoint/CGFloat(rangeValue)) + CGFloat(minPoint)
			return point
		}
	
		func setValueFromPoint(point: CGFloat) -> Int {
			
			let value = Int((point-minPoint)*CGFloat(rangeValue)/rangePoint)
			
			valueSliderSK = value>maxValue ? maxValue : value
			valueSliderSK = value<minValue ? minValue : value
			
			return valueSliderSK
		}

}
