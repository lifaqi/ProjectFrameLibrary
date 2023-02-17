//
//  UITextView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/12.
//

import UIKit

public typealias ShouldChangeTextInCallBack = (_ textView: UITextView, _ range: NSRange, _ text: String) -> (Bool)
public typealias TextViewDidChangeCallBack = (_ textView: UITextView) -> ()

var textView: SWYTextView!

public extension UITextView {
    
    // MARK: - property
    /// 要放在text复制的后面，要依据是否有初始化值来判断是否显示placeholder
    var placeholder: String {
        get {
            if let value = objc_getAssociatedObject(self, &AssociatedKeys.placeholderKey) as? String {
                return value
            }
            return ""
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            textView.basePlaceholder = newValue
        }
    }
    
    var placeholderColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &AssociatedKeys.placeholderColorKey) as? UIColor {
                return color
            }
            return rgba(200, 200, 200, 1)
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeholderColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            textView.basePlaceholderColor = newValue
        }
    }
    
    /// 左右边距
    var leftPadding: CGFloat {
        get {
            if let padding = objc_getAssociatedObject(self, &AssociatedKeys.leftPaddingKey) as? CGFloat {
                return padding
            }
            return 15
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.leftPaddingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            textView.baseLeftPadding = newValue
        }
    }
    
    /// 上下边距
    var topPadding: CGFloat {
        get {
            if let padding = objc_getAssociatedObject(self, &AssociatedKeys.topPaddingKey) as? CGFloat {
                return padding
            }
            return 15
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.topPaddingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            textView.baseTopPadding = newValue
        }
    }
    
    /// 最大高度
    var maxHeight: CGFloat {
        get {
            if let height = objc_getAssociatedObject(self, &AssociatedKeys.maxHeightKey) as? CGFloat {
                return height
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.maxHeightKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            textView.baseMaxHeight = newValue
        }
    }

    /// 最大长度，放在text的后面，如果初始化了，根据初始化的值做判断是否超了最大长度
    var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &AssociatedKeys.maxLengthKey) as? Int {
                return length
            }
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.maxLengthKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            textView.baseMaxWordNum = newValue
            
            if self.text.count > maxLength {
                self.text = self.text[0..<maxLength]
            }
        }
    }
    
    // MARK: - func
    static func createTextView(size: CGFloat = 16, textColor: UIColor = BlackColor, placeholder: String = "", style: UIFont.Weight = .regular) -> SWYTextView {
        textView = SWYTextView()
        textView.font = UIFont.systemFont(ofSize: size, weight: style)
        textView.textColor = textColor
        
        return textView
    }
    
    
    func shouldChangeTextInCallBack(shouldChangeTextInCallBack: @escaping ShouldChangeTextInCallBack) {
        textView.shouldChangeTextInCallBack = shouldChangeTextInCallBack
    }

    func textViewDidChangeCallBack(textViewDidChangeCallBack: @escaping TextViewDidChangeCallBack) {
        textView.textViewDidChangeCallBack = textViewDidChangeCallBack
    }
}

private struct AssociatedKeys {
    static var placeholderKey = "placeholderKey"
    static var placeholderColorKey = "placeholderColorKey"
    static var leftPaddingKey = "leftPaddingKey"
    static var topPaddingKey = "topPaddingKey"
    static var maxLengthKey = "maxLengthKey"
    static var maxHeightKey = "maxHeightKey"
    
}

