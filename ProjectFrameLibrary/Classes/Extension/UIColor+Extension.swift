//
//  UIColor+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

public extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(
            red: r / 255,
            green: g / 255.0,
            blue: b / 255.0,
            alpha: a
        )
    }
    
    static var random: UIColor {
        return UIColor(red: CGFloat(arc4random_uniform(256))/255.0,
                       green: CGFloat(arc4random_uniform(256))/255.0,
                       blue: CGFloat(arc4random_uniform(256))/255.0,
                       alpha: 1.0)
    }
}

