//
//  UITableView+Extension.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/7/7.
//

import Foundation

private var _isShowBottomSafeArea = true

extension UITableView {
    /// 默认是true，底部的安全区域会挡住最后一个cell，设置底部内边距，往上移动显示区域，如果设为true就不会被挡住
    var isShowBottomSafeArea: Bool {
        get {
            return _isShowBottomSafeArea
        }
        set {
            _isShowBottomSafeArea = newValue
            
            self.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: newValue ? SafeAreaInsets!.bottom : 0, right: 0)
        }
    }
}
