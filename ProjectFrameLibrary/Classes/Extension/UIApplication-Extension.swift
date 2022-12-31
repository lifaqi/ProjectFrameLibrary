//
//  UIApplication-Extension.swift
//  ProjectFrameSwift
//
//  Created by apple on 2022/1/14.
//

import UIKit

extension UIApplication {
    
    static var keyWindow: UIWindow? {
        // Get connected scenes
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return nil }
            guard let window = windowScene.windows.first else { return nil }
            return window
        } else {
            // Fallback on earlier versions
            return UIApplication.shared.windows.first
        }
    }
    
    static func getTopViewController(base: UIViewController? = UIApplication.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return getTopViewController(base: nav.visibleViewController)
        }else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewController(base: selected)
        }else if let presented = base?.presentedViewController {
            return getTopViewController(base: presented)
        }
        
        return base
    }
    
    /// 顶部状态栏高度（包括安全区）
    static func getStatusBarHeight() -> CGFloat {
        var statusBarHeight: CGFloat = 0
        if #available(iOS 13.0, *) {
            let scene = UIApplication.shared.connectedScenes.first
            guard let windowScene = scene as? UIWindowScene else { return 0 }
            guard let statusBarManager = windowScene.statusBarManager else { return 0 }
            statusBarHeight = statusBarManager.statusBarFrame.height
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
