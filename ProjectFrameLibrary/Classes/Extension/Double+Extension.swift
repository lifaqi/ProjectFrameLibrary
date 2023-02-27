//
//  Double+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/10.
//

import Foundation

var _auto: Double = 0.0

public extension Double {
    var ad: Double {
        get{
            return self / UIScreenWidth * ScreenWidth
        }
    }
    
    /// isRounding：是否四舍五入
    func toInt(isRounding: Bool = false) -> Int {
        if self >= Double(Int.min) && self < Double(Int.max) {
            if isRounding {
                return lround(self)
            }else{
                return Int(self)
            }
        } else {
            return 0
        }
    }
    
    /// Double to String
    /// - Parameters:
    ///   - minimum: 最小保留小数位数
    ///   - maximum: 最大保留小数位数
    ///   - numberStyle:decimal:小数形式 spellOut:中文形式表示 scientific:科学计数法表示
    ///   - roundingMode: halfUp:四舍五入 ceiling:向上取整 floor:向下取整
    /// - Returns: 返回一个String
    func toString(minimum: Int = 0, maximum: Int = 2, numberStyle: NumberFormatter.Style = .decimal, roundingMode: NumberFormatter.RoundingMode = .halfUp) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = minimum // 设置小数点后最少几位
        formatter.maximumFractionDigits = maximum // 设置小数点后最多几位
        formatter.numberStyle = numberStyle
        formatter.roundingMode = roundingMode
        return formatter.string(from: self as NSNumber) ?? ""
    }
}
