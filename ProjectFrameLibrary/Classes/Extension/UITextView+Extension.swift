//
//  UITextView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/12.
//

import UIKit

private var _placeholder = ""
private var _placeholderColor = rgba(200, 200, 200, 1)
private var _leftPaddding = 15.ad
private var _rightPaddding = 15.ad
private var _topPaddding = 15.ad
private var _maxHeight = 150.0
private var _maxWordNum = 0

public typealias ShouldChangeTextInCallBack = (_ textView: UITextView, _ range: NSRange, _ text: String) -> (Bool)
public typealias TextViewDidChangeCallBack = (_ textView: UITextView) -> ()

var textView: SWYTextView!

var placeholderLabel: UILabel!

public extension UITextView {
    
    // MARK: - property
    var placeholder: String {
        get {
            return _placeholder
        }
        set {
            _placeholder = newValue
            
            // placeholderLabel
            placeholderLabel = UILabel.createLabel()
            self.addSubview(placeholderLabel)
            placeholderLabel.font = self.font
            placeholderLabel.textColor = _placeholderColor
            placeholderLabel.text = _placeholder
            self.setValue(placeholderLabel, forKey: "_placeholderLabel")
        }
    }
    
    var placeholderColor: UIColor {
        get {
            return _placeholderColor
        }
        set {
            _placeholderColor = newValue
            
            placeholderLabel.textColor = newValue
        }
    }
    
    var leftPadding: CGFloat {
        get {
            return _leftPaddding
        }
        set {
            _leftPaddding = newValue
            
            self.textContainer.lineFragmentPadding = _leftPaddding
        }
    }
    
    var maxHeight: Double {
        get {
            return _maxHeight
        }
        set {
            _maxHeight = newValue
            
            textView.baseMaxHeight = newValue
        }
    }
    
    var maxWordNum: Int {
        get {
            return _maxWordNum
        }
        set {
            _maxWordNum = newValue
            
            textView.baseMaxWordNum = newValue
        }
    }
    
    // MARK: - func
    static func createTextView(font: UIFont = UIFont.systemFont(ofSize: 16), textColor: UIColor = UIColor(r: 25, g: 25, b: 25, a: 1)) -> UITextView {
        textView = SWYTextView()
        textView.font = font
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
