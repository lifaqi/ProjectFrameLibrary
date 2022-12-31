//
//  UIScrollView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/3/29.
//

import UIKit

extension UIScrollView {
    static func createScrollView() -> UIScrollView {
        let scrollView = UIScrollView()
        // 去掉状态栏
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never;
        }
        return scrollView
    }
}
