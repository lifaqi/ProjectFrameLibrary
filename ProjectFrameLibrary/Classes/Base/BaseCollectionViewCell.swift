//
//  BaseCollectionViewCell.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/12/29.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    /// cell高度
    class func cellHeight() -> CGFloat { return 0 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initData()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化数据
    func initData() {
        
    }
    
    /// 构建UI
    func setupView() {
        
    }
    
    /// 加载数据
    func loadData() {
        
    }
}
