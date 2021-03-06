//
//  CustomControl.swift
//  UserStarRating
//
//  Created by Benjamin Hakes on 1/8/19.
//  Copyright © 2019 Benjamin Hakes. All rights reserved.
//

import UIKit

class CustomControl: UIControl {
    
    var value: Int = 1 {
        didSet {
            
        }
    }
    private var labelArray: [UILabel] = []
    private let componentDimension: CGFloat = 40.0
    private let componentCount = 5
    private let componentActiveColor = UIColor.black
    private let componentInactiveColor = UIColor.gray
    
    required init?(coder aCoder: NSCoder){
        super.init(coder: aCoder)
        
        setup()
    }
    
    private func setup(){
        for x in 0..<5{
            labelArray.append(UILabel())
            guard let mostRecentLabel = labelArray.last else {fatalError("could not get last element")}
            mostRecentLabel.tag = x + 1
            mostRecentLabel.frame = CGRect(origin: CGPoint(x: 8.0 + (Double(x) * 40.0), y: 0.0), size: CGSize(width: componentDimension, height: componentDimension))
            mostRecentLabel.font = UIFont.boldSystemFont(ofSize: CGFloat(integerLiteral: 32))
            mostRecentLabel.text = "★"
            mostRecentLabel.textAlignment = .center
            if x > 0 {
                mostRecentLabel.textColor = componentActiveColor
            } else {
                mostRecentLabel.textColor = componentInactiveColor
            }
            
            self.addSubview(mostRecentLabel)
            
            
        }
    }
    
    override var intrinsicContentSize: CGSize {
        let componentsWidth = CGFloat(componentCount) * componentDimension
        let componentsSpacing = CGFloat(componentCount + 1) * 8.0
        let width = componentsWidth + componentsSpacing
        return CGSize(width: width, height: componentDimension)
    }
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        updateValue(at: touch)
        sendActions(for: [.touchDown,.valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        defer {
            super.endTracking(touch, with: event)
        }
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint){
            // TODO: Implement func
            updateValue(at: touch)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer {
            super.endTracking(touch, with: event)
        }
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint){
            updateValue(at: touch)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
        
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
        super.cancelTracking(with: event)
    }
    
    func updateValue(at touch: UITouch) {
        
        let touchPoint = touch.location(in: self)
        print(touchPoint)
        for index in 0..<labelArray.count {
            
            
            if labelArray[index].frame.contains(touchPoint){
                value = labelArray[index].tag
                print(value)
                sendActions(for: [.valueChanged])
                print(labelArray[index].frame)
                for label in labelArray {
                    
                    if label.tag <= index + 1{
                        label.textColor = componentInactiveColor
                    } else {
                        label.textColor = componentActiveColor
                    }
                }
                
                
            }
            
        }
        
    }
    
}
