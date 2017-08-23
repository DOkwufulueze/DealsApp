//
//  RatingControl.swift
//  DealsApp
//
//  Created by Okwufulueze Daniel on 05/07/2016.
//  Copyright © 2016 Okwufulueze Daniel. All rights reserved.
//

import UIKit

class RatingControl: UIView{

    var rating = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var ratingButtons = [UIButton]()
    let numberOfStars = 5
    let spaceBetweenStars = 5
    
//    func setUpView() {
//        let ratingImage = UIImage(named: "ratingImage")
//        let ratingFullImage = UIImage(named: "ratingFullImage")
//        
//        for _ in 0..<5 {
//            let button = UIButton()
//            button.setImage(ratingImage, forState: .Normal)
//            button.setImage(ratingFullImage, forState: .Selected)
//            button.setImage(ratingFullImage, forState: [.Highlighted, .Selected])
//            
//            button.adjustsImageWhenHighlighted = false
//            button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchDown)
//            ratingButtons.append(button)
//            addSubview(button)
//        }
//    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let ratingImage = UIImage(named: "ratingImage")
        let ratingFullImage = UIImage(named: "ratingFullImage")
        
        for _ in 0..<5 {
            let button = UIButton()
            button.setImage(ratingImage, forState: .Normal)
            button.setImage(ratingFullImage, forState: .Selected)
            button.setImage(ratingFullImage, forState: [.Highlighted, .Selected])
            
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchDown)
            ratingButtons.append(button)
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + 5))
            button.frame = buttonFrame
        }
        updateButtonSelectionStates()
    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * numberOfStars) + (spaceBetweenStars * (numberOfStars - 1))
        
        return CGSize(width: width, height: buttonSize)
    }
    
    func buttonPressed(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in ratingButtons.enumerate() {
            button.selected = index < rating
        }
    }
}
