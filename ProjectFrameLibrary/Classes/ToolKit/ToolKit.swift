//
//  ToolKit.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/8.
//

import UIKit
import SVProgressHUD

public class ToolKit: NSObject {
    /// 获取区间内随机数，[startNumber, endNumer)
    public static func getRandomNumer(startNumber: UInt32, endNumer: UInt32) -> Int {
        return Int(arc4random_uniform(endNumer - startNumber) + startNumber)
    }
    
    // MARK: - 图片
    /// imageName：必须是全名， 如：test@2x.png
    public static func bundleForImage(imageName: String) -> UIImage {
        var bundleUrl = Bundle.main.url(forResource: "Frameworks", withExtension: nil)
        if #available(iOS 16.0, *) {
            bundleUrl = bundleUrl?.appending(path: "ProjectFrameLibrary")
        } else {
            // Fallback on earlier versions
            bundleUrl = bundleUrl?.appendingPathComponent("ProjectFrameLibrary")
        }
        bundleUrl = bundleUrl?.appendingPathExtension("framework")
        
        var bundle = Bundle(url: bundleUrl!)
        bundleUrl = bundle?.url(forResource: "ProjectFrameLibrary", withExtension: "bundle")
        bundle = Bundle(url: bundleUrl!)
        
        return UIImage(contentsOfFile: bundle!.path(forResource: imageName, ofType: nil)!)!
    }
    
    //MARK: - SVProgressHUD
    public static func show() {
        changeShowType()
        SVProgressHUD.show()
    }
    
    public static func show(msg: String) {
        changeShowType()
        SVProgressHUD.show(withStatus: msg)
    }
    
    public static func showInfo(msg: String) {
        changeShowType()
        SVProgressHUD.showInfo(withStatus: msg)
    }
    
    public static func showSuccess(msg: String) {
        changeShowType()
        SVProgressHUD.showSuccess(withStatus: msg)
    }
    
    public static func showError(msg: String) {
        changeShowType()
        SVProgressHUD.showError(withStatus: msg)
    }
    
    public static func showProgress(msg: String, progressValue: Float) {
        changeShowType()
        SVProgressHUD.showProgress(progressValue, status: msg)
    }
    
    public static func dismiss() {
        SVProgressHUD.dismiss()
    }
    
    public static func changeShowType() {
        // SVProgressHUD全局设置
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
    }
}
