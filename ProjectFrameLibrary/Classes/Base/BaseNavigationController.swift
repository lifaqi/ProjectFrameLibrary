//
//  BaseNavigationController.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

open class BaseNavigationController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    open override var childForStatusBarStyle: UIViewController?{
        return self.topViewController
    }
    
    open override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            // 当前导航栏, 只有第一个viewController push的时候设置隐藏
            if self.viewControllers.count == 1 {
                viewController.hidesBottomBarWhenPushed = true
            }
        }else{
            viewController.hidesBottomBarWhenPushed = false
        }
        
        super.pushViewController(viewController, animated: animated)
    }

}
