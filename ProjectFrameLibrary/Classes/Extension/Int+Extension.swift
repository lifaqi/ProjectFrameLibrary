//
//  Int+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/10.
//

import Foundation

public extension Int {
    func toDouble() -> Double {
        Double(self)
    }
    
    func toString() -> String {
        String(format: "%d", self)
    }
}
