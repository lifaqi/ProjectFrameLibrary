//
//  Common.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/5.
//

import UIKit

// MARK: - 尺寸大小
let UIScreenWidth = 375.0 // UI设计原型图的手机尺寸宽度

let window = UIApplication.keyWindow
let tabbarVC = TabBarViewController()

let SafeAreaInsets = window?.safeAreaInsets
let StatusBarHeight: CGFloat = UIApplication.getStatusBarHeight()
let NavigationBarHeight: CGFloat = 44
let HeaderHeight = StatusBarHeight + NavigationBarHeight
let TabBarHeight: CGFloat = (SafeAreaInsets?.bottom ?? 0) + tabbarVC.tabBar.frame.size.height
let ScreenWidth = UIScreen.main.bounds.size.width
let ScreenHeight = UIScreen.main.bounds.size.height

// MARK: - 颜色
let NavigationBarColor = UIColor(r: 245, g: 245, b: 245, a: 1)
let NavigationTitleColor = UIColor(r: 55, g: 55, b: 55, a: 1)
let TitleColor = UIColor(r: 25, g: 25, b: 25, a: 1)
let BackGroundColor = UIColor(r: 255, g: 255, b: 255, a: 1)
let SeparatorColor = UIColor(r: 230, g: 230, b: 230, a: 1)
let BlackColor = UIColor(r: 25, g: 25, b: 25, a: 1)
let RedColor = UIColor(r: 250, g: 62, b: 56, a: 1)
let WhiteColor = UIColor(r: 255, g: 255, b: 255, a: 1)
let Color245 = UIColor(r: 245, g: 245, b: 245, a: 1)

func rgba(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat) -> UIColor {
    return UIColor(r: r, g: g, b: b, a: a)
}

//  MARK: - 获取系统版本号和历史版本号
//获取当前版本号
let currentVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
// 获取历史版本号
let sandboxVersion = UserDefaults.standard.object(forKey: "CFBundleShortVersionString") as? String ?? ""

// MARK: - 获取APP信息、名称、版本号以及build版本号
// 获取app信息
let infoDictionary : Dictionary = Bundle.main.infoDictionary!
// 程序名称
let appDisplayName : String = infoDictionary["CFBundleDisplayName"] as! String
// 版本号
let majorVersion : String = infoDictionary ["CFBundleShortVersionString"] as! String
// build号
let minorVersion : String = infoDictionary ["CFBundleVersion"] as! String

// MARK: - 获取设备信息
// 系统名称
let systemName : String = UIDevice.current.systemName
// ios版本
let iosVersion : NSString = UIDevice.current.systemVersion as NSString
// 设备udid
let identifierNumber  = UIDevice.current.identifierForVendor
// 设备名称
let deviceName : String = UIDevice.current.name
// 设备型号
let deviceModel = UIDevice.current.model
// 设备区域化型号如A1533
let deviceLocalizedModel = UIDevice.current.localizedModel
// 设备UUID
let deviceUUID = FCUUID.uuidForDevice()

// MARK: - 常用参数
var dateFormatter: DateFormatter = {
    let df = DateFormatter()
    df.timeZone = TimeZone.current
    df.locale = Locale.current // Locale.init(identifier: "zh_CN")
    return df
}()
