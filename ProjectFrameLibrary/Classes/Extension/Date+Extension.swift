//
//  Date+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/10.
//

import Foundation

public extension Date {
    var millisecondsSince1970: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
    
    func toString(format: String = "yyyy-MM-dd HH:mm:ss") -> String {
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    
    func timeDifference(toDate: Date, components: Set<Calendar.Component> = [.day, .hour, .minute, .second]) -> DateComponents {
        let components = Calendar.current.dateComponents(components, from: self, to: toDate)
        
        return components
    }
}
