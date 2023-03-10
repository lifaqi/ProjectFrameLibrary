//
//  BaseAlertView.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/4/11.
//

import UIKit
import SwiftUI

open class BaseAlertView: BaseView {
    /// 可以自定义父类view
    private var topView: UIView = (UIApplication.getTopViewController()?.view)! {
        didSet {
            bgView.removeFromSuperview()
            superView.removeFromSuperview()
            
            topView.addSubview(bgView)
            bgView.snp.makeConstraints { make in
                make.edges.equalTo(topView)
            }

            topView.addSubview(superView)
            superView.snp.makeConstraints { make in
                make.edges.equalTo(topView)
            }
            superView.addTouchUpInSideAction { button in
                self.hiddenView()
            }
        }
    }
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = rgba(100, 100, 100, 0.8)
        return view
    }()
    
    lazy public var superView: UIButton = {
        let button = UIButton.createButton()
        button.backgroundColor = UIColor.clear
        return button
    }()

    open override func initConfig() {
        super.initConfig()
    }
    
    open override func initData() {
        super.initData()
    }
    
    open override func setupView() {
        super.setupView()
        
        // bgView
        topView.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.edges.equalTo(topView)
        }
        
        // bodyView
        topView.addSubview(superView)
        superView.snp.makeConstraints { make in
            make.edges.equalTo(topView)
        }
        superView.addTouchUpInSideAction { button in
            self.hiddenView()
        }
    }
    
    // func
    public func showView(topView: UIView = (UIApplication.getTopViewController()?.view)!) {
        self.topView = topView
        
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 0.8
            self.superView.alpha = 1
        } completion: { finish in
            
        }

    }
    
    public func hiddenView() {
        UIView.animate(withDuration: 0.3) {
            self.bgView.alpha = 0
            self.superView.alpha = 0
        } completion: { finish in
            
        }
    }

}
