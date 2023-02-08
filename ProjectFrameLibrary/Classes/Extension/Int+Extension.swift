//
//  Int+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/10.
//

import Foundation

public extension Int {
    func toFloat() -> CGFloat {
        return CGFloat(self)
    }
    
    func toDouble() -> Double {
        return Double(self)
    }
    
    func toString() -> String {
        return String(format: "%d", self)
    }
}
