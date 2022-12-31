//
//  BaseTableViewCell.swift
//  ProjectFrameSwift
//
//  Created by mac on 2020/8/6.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    /// 重用标识
    static var reuseIdentifier: String {
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
