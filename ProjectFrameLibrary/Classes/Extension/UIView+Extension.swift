//
//  UIView+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

public extension UIView {
    /// 添加圆角
    var cornerRadius: Double {
        get{
            return self.layer.cornerRadius
        }
        set{
            self.layer.masksToBounds = true
            self.layer.cornerRadius = newValue
        }
    }
    
    /// 添加边框
    func borderStyle(borderWidth: Double, borderColor: UIColor) {
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    /// 添加阴影
    func showShadow(radius: CGFloat) {
        self.layer.cornerRadius = radius;
        self.backgroundColor = rgba(255, 255, 255, 1);
        self.layer.shadowColor = rgba(200, 200, 200, 1).cgColor;
        self.layer.shadowOffset = CGSize.init(width: 0, height: 0);
        self.layer.shadowRadius = radius;
        self.layer.shadowOpacity = 0.5;
    }
}
