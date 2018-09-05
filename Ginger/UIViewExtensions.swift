//
//  UIViewExtensions.swift
//  Ginger
//
//  Created by Sabrina Ren on 2018-08-29.
//  Copyright © 2018 Sabrina Ren. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setGradient(colourOne: UIColor, colourTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colourOne.cgColor, colourTwo.cgColor]
        gradientLayer.locations = [0.0, 2.5] // breakpoint in gradient
        gradientLayer.startPoint = CGPoint(x: 0.3, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.7)
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIView : UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
