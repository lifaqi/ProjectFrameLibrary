//
//  Common.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

// MARK: - 常用参数
var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = TimeZone.current
    df.locale = Locale.current // Locale.init(identifier: "zh_CN")
    return df
}()
