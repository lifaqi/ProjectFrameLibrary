//
//  UITextField+Extension.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

public typealias AddTouchUpInSideAction = (_ textField: UITextField)->()

public extension UITextField {
    static func createTextField(size: CGFloat = 16, textColor: UIColor = BlackColor, placeholder: String = "", style: UIFont.Weight = .regular) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: size, weight: style)
        textField.textColor = textColor
        textField.placeholder = placeholder
        
        // 设置下划线
        textField.borderStyle = .none
        textField.layer.backgroundColor = UIColor.white.cgColor
        textField.layer.masksToBounds = false
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        textField.layer.shadowOpacity = 1.0
        textField.layer.shadowRadius = 0.0
        textField.layer.shadowColor = rgba(239, 239, 239, 1).cgColor
        
        return textField
    }
    
    // 最大输入字符数，使用计算属性的形式实现
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &AssociatedKeys.maxLength) as? Int {
                return length
            }
            return Int.max
        }
        set {
            if self.delegate == nil {
                self.delegate = self
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.maxLength, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTarget(self, action: #selector(limitLength), for: .editingChanged)
        }
    }
    
    @IBInspectable var underLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &AssociatedKeys.underLineColor) as? UIColor {
                return color
            }else {
                return rgba(239, 239, 239, 1)
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.underLineColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            self.layer.shadowColor = underLineColor.cgColor
            addTarget(self, action: #selector(textFieldUnderLineColor), for: .editingDidBegin)
        }
    }
    
    @IBInspectable var selectUnderLineColor: UIColor {
        get {
            if let color = objc_getAssociatedObject(self, &AssociatedKeys.selectUnderLineColor) as? UIColor {
                return color
            }else {
                return rgba(239, 239, 239, 1)
            }
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.selectUnderLineColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            addTarget(self, action: #selector(textFieldSelectUnderLineColor), for: .editingDidEnd)
        }
    }
    
    
    /// 是否可以编辑，默认：true
    @IBInspectable var isEdit: Bool {
        get {
            if let edit = objc_getAssociatedObject(self, &AssociatedKeys.isEdit) as? Bool {
                return edit
            }else {
                return true
            }
        }
        set {
            if self.delegate == nil {
                self.delegate = self
            }
            
            objc_setAssociatedObject(self, &AssociatedKeys.isEdit, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - func
    // 辅助方法，用于限制文本框的输入字符数
    @objc func limitLength() {
        guard let text = text, text.count > maxLength else {
            return
        }
        let truncated = text.prefix(maxLength)
        self.text = String(truncated)
    }
    
    @objc func textFieldUnderLineColor(textField: UITextField) {
        textField.layer.shadowColor = selectUnderLineColor.cgColor
    }
    
    @objc func textFieldSelectUnderLineColor(textField: UITextField) {
        textField.layer.shadowColor = underLineColor.cgColor
    }
    
    func addTouchUpInSideAction(_ callback: @escaping AddTouchUpInSideAction){
        self.isEdit = false
        
        self.isUserInteractionEnabled = true
        self.addTarget(self, action: #selector(touchUpInSideAction), for: .touchDown)
        
        objc_setAssociatedObject(self, &AssociatedKeys.addTouchUpInSideAction, callback, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc fileprivate func touchUpInSideAction(textField: UITextField) {
        if let callback = objc_getAssociatedObject(self, &AssociatedKeys.addTouchUpInSideAction) as? AddTouchUpInSideAction {
            callback(textField)
        }
    }
}

extension UITextField: UITextFieldDelegate {
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.isEdit
    }
}

private struct AssociatedKeys {
    static var maxLength = "maxLength"
    static var underLineColor = "underLineColor"
    static var selectUnderLineColor = "selectUnderLineColor"
    static var isEdit = "isEdit"
    static var addTouchUpInSideAction = "addTouchUpInSideAction"
}
