//
//  UIViewController+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/4/7.
//

import Foundation

public extension UIViewController {
    func popGestureClose() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = false
            }
        }
    }
    
    func popGestureOpen() {
        if let ges = self.navigationController?.interactivePopGestureRecognizer?.view?.gestureRecognizers {
            for item in ges {
                item.isEnabled = true
            }
        }
    }
}
