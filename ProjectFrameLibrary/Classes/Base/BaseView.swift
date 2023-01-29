//
//  BaseView.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/4/11.
//

import UIKit

open class BaseView: UIView {
    
    public init() {
        super.init(frame: CGRect.zero)
        
        initConfig()
        initData()
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func initConfig() {
        
    }
    
    open func initData() {
        
    }
    
    open func setupView() {
        
    }

}
