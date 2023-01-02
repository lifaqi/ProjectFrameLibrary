//
//  ToolKit.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/8.
//

import UIKit
import SVProgressHUD

class ToolKit: NSObject {
    /// 获取区间内随机数，[startNumber, endNumer)
    static func getRandomNumer(startNumber: UInt32, endNumer: UInt32) -> Int {
        return Int(arc4random_uniform(endNumer - startNumber) + startNumber)
    }
    
    //MARK: - SVProgressHUD
    static func show() {
        changeShowType()
        SVProgressHUD.show()
    }
    
    static func show(msg: String) {
        changeShowType()
        SVProgressHUD.show(withStatus: msg)
    }
    
    static func showInfo(msg: String) {
        changeShowType()
        SVProgressHUD.showInfo(withStatus: msg)
    }
    
    static func showSuccess(msg: String) {
        changeShowType()
        SVProgressHUD.showSuccess(withStatus: msg)
    }
    
    static func showError(msg: String) {
        changeShowType()
        SVProgressHUD.showError(withStatus: msg)
    }
    
    static func showProgress(msg: String, progressValue: Float) {
        changeShowType()
        SVProgressHUD.showProgress(progressValue, status: msg)
    }
    
    static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    static func changeShowType() {
        // SVProgressHUD全局设置
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
    }
}
