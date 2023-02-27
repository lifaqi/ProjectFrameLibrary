//
//  Date+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/10.
//

import Foundation

public extension Date {
    /// Date to TimeInterval：毫秒
    var toMillisecondsSince1970: Int64 {
        Int64(self.timeIntervalSince1970 * 1000)
    }
    
    /// Date to String
    func toString(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    
    /// 计算时间差
    func timeDifference(toDate: Date, components: Set<Calendar.Component> = [.day, .hour, .minute, .second]) -> DateComponents {
        let components = Calendar.current.dateComponents(components, from: self, to: toDate)
        
        return components
    }
    
    /// 获取当前日期
    func getCurrentDate(dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let dateCurrent = Date()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: dateCurrent)
    }
    
    /// Date to DateComponents
    func toDateComponents(components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]) -> DateComponents {
        let comps = Calendar.current.dateComponents(components, from: self)
        return comps
    }
}

public extension DateComponents {
    /// DateComponents to Date
    func toDate() -> Date {
        let date = Calendar.current.date(from: self)
        return date ?? Date()
    }
}
