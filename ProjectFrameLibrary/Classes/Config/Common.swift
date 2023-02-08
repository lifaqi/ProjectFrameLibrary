//
//  Common.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

// MARK: - 尺寸大小
let window = UIApplication.keyWindow

public let SafeAreaInsets = window?.safeAreaInsets
public let StatusBarHeight: CGFloat = UIApplication.getStatusBarHeight()
public let NavigationBarHeight: CGFloat = 44
public let HeaderHeight = StatusBarHeight + NavigationBarHeight
public let TabBarHeight: CGFloat = (SafeAreaInsets?.bottom ?? 0) + 49
public let ScreenWidth = UIScreen.main.bounds.size.width
public let ScreenHeight = UIScreen.main.bounds.size.height

/// UI设计原型图的手机尺寸宽度，默认是375.0
public var UIScreenWidth = 375.0

// MARK: - 颜色
public func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(r: r, g: g, b: b, a: a)
}

public var SeparatorColor = rgba(230, 230, 230, 1)
public let BlackColor = rgba(34, 34, 34, 1)

//  MARK: - 获取系统版本号和历史版本号
//获取当前版本号
public let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
// 获取历史版本号
public let sandboxVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") as? String ?? ""

// MARK: - 获取APP信息、名称、版本号以及build版本号
/// 获取app信息
public let infoDictionary : Dictionary = Bundle.main.infoDictionary!
/// 程序名称
public let appDisplayName : String = infoDictionary["CFBundleDisplayName"] as! String
/// 版本号
public let majorVersion : String = infoDictionary ["CFBundleShortVersionString"] as! String
/// build号
public let minorVersion : String = infoDictionary ["CFBundleVersion"] as! String

// MARK: - 获取设备信息
/// 系统名称
public let systemName : String = UIDevice.current.systemName
/// ios版本
public let iosVersion : NSString = UIDevice.current.systemVersion as NSString
/// 设备udid
public let identifierNumber  = UIDevice.current.identifierForVendor
/// 设备名称
public let deviceName : String = UIDevice.current.name
/// 设备型号
public let deviceModel = UIDevice.current.model
/// 设备区域化型号如A1533
public let deviceLocalizedModel = UIDevice.current.localizedModel
/// 设备UUID
public let deviceUUID = FCUUID.uuidForDevice()

// MARK: - 常用参数
public var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = TimeZone.current
    df.locale = Locale.current // Locale.init(identifier: "zh_CN")
    return df
}()

public func SWYPrint<T>(_ object: T?, filename: String = #file, line: Int = #line, funcname: String = #function) {
    #if DEBUG
        guard let object = object else { return }
        print("***** \(Date()) \(filename.components(separatedBy: "/").last ?? "") (line: \(line)) :: \(funcname) :: \(object)")
    #endif
}
