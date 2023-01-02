//
//  BaseView.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/4/11.
//

import UIKit

open class BaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initConfig()
        initData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initConfig() {
        
    }
    
    func initData() {
        
    }
    
    func setupView() {
        
    }

}
