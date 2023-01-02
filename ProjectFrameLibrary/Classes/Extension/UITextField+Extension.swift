//
//  UITextField+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

public extension UITextField {
    static func createTextField(size: CGFloat = 16, textColor: UIColor = BlackColor, placeholder: String = "") -> UITextField {
        return self.createTextField(size: size, textColor: textColor, placeholder: placeholder, style: .regular)
    }
    
    static func createTextField(size: CGFloat, textColor: UIColor, placeholder: String, style: UIFont.Weight) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: size, weight: .regular)
        textField.textColor = textColor
        textField.placeholder = placeholder
        return textField
    }
}
