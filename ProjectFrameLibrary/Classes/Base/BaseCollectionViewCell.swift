//
//  BaseCollectionViewCell.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/12/29.
//

import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    /// cell高度
    public class func cellHeight() -> CGFloat { return 0 }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initData()
        setupView()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 初始化数据
    open func initData() {
        
    }
    
    /// 构建UI
    open func setupView() {
        
    }
    
    /// 加载数据
    open func loadData() {
        
    }
}
