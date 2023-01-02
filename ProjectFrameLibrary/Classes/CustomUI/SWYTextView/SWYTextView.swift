//
//  SWYTextView.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/29.
//

import UIKit

public class SWYTextView: UITextView {

    var baseMaxHeight = 150.0 // 定义最大高度
    var baseMaxWordNum = 0
    
    typealias ShouldChangeTextInCallBack = (_ textView: UITextView, _ range: NSRange, _ text: String) -> (Bool)
    var shouldChangeTextInCallBack: ShouldChangeTextInCallBack?
    
    typealias TextViewDidChangeCallBack = (_ textView: UITextView) -> ()
    var textViewDidChangeCallBack: TextViewDidChangeCallBack?
    
    override init(frame: CGRect = .zero, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        self.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SWYTextView: UITextViewDelegate {
    public func textViewDidChange(_ textView: UITextView) {
        // 获取frame值
        let frame = textView.frame
        // 定义一个constrainSize值用于计算textview的高度
        let constrainSize = CGSize(width: frame.size.width, height: CGFloat(MAXFLOAT))
        // 获取textview的真实高度
        var size = textView.sizeThatFits(constrainSize)
        // 如果textview的高度大于最大高度高度就为最大高度并可以滚动，否则不能滚动
        if size.height >= baseMaxHeight{
            size.height = baseMaxHeight
            textView.isScrollEnabled = true
        }else{
            textView.isScrollEnabled = false
        }
        
        // 重新设置textview的高度
        Async.main {
            textView.frame.size.height = size.height
            
            if self.textViewDidChangeCallBack != nil {
                self.textViewDidChangeCallBack!(textView)
            }
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if baseMaxWordNum != 0 {
            if range.length == 0 && text == " " {
                return false
            }
            
            let num = textView.text!.count - range.length + text.count
            if num > baseMaxWordNum {
                return false
            }
        }
        
        if shouldChangeTextInCallBack != nil {
            return shouldChangeTextInCallBack!(textView, range, text)
        }
        
        return true
    }
}
