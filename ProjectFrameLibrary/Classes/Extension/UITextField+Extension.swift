//
//  UITextField+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

public extension UITextField {
    static func createTextField(size: CGFloat = 16, textColor: UIColor = BlackColor, placeholder: String = "", style: UIFont.Weight = .regular) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: size, weight: style)
        textField.textColor = textColor
        textField.placeholder = placeholder
        return textField
    }
}
