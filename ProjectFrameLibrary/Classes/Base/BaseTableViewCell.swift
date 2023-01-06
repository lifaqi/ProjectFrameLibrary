//
//  BaseTableViewCell.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

open class BaseTableViewCell: UITableViewCell {

    /// 重用标识
    public static var reuseIdentifier: String {
        return NSStringFromClass(self)
    }
    
    /// cell高度
    class func cellHeight() -> CGFloat { return 0 }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        
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
