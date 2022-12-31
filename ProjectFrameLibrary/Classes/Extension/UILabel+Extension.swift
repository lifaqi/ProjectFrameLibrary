//
//  UILabel+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

private var _textInsets: UIEdgeInsets = .zero

extension UILabel {
    /// 设置内边距
    var textInsets: UIEdgeInsets {
        get {
            return _textInsets
        }
        set {
            _textInsets = newValue
            
            let label: SWYUILabel = self as! SWYUILabel
            label.textContainerInset = newValue
        }
    }
    
    static func createLabel(size: CGFloat = 16, textColor: UIColor = UIColor(r: 25, g: 25, b: 25, a: 1), style: UIFont.Weight = .regular) -> UILabel {
        let label = SWYUILabel()
        label.font = UIFont.systemFont(ofSize: size, weight: style)
        label.textColor = textColor
        return label
    }
    
    func setTxtFontOrColor(content: String?, font: UIFont? = nil, color: UIColor? = nil) {
        let textString = NSString(string: self.text ?? "")
        let range = textString.range(of: content ?? "")
        
        let attr = NSMutableAttributedString(string: self.text ?? "")
        if font != nil {
            attr.addAttribute(.font, value: font!, range: range)
        }
        if color != nil {
            attr.addAttribute(.foregroundColor, value: color!, range: range)
        }
        self.attributedText = attr
    }
}
