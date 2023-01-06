//
//  BaseTableViewController.swift
//  ProjectFrameSwift
//
//  Created by apple on 2021/5/17.
//

import UIKit

private let CellIdentifier = "TableViewCell"

open class BaseTableViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0)
    var pageNo = 1
    var pageSize = 20
    
    // view
    public lazy var tableView: UITableView = {
        let tableView = UITableView.init()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 44
        tableView.separatorColor = SeparatorColor
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: SafeAreaInsets?.bottom ?? 0, right: 0)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
        
        // 去掉状态栏
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never;
        }
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0;
        }
        
        return tableView
    }()
    
    override func mainNavView() {
        super.mainNavView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelRefreshLoading), name: CancelRefreshLoading, object: nil)
    }
    
    open override func initData() {
        
    }
    
    open override func setupView() {
        
    }
    
    open func setupCell() -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifier)
        if (cell == nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: CellIdentifier)
        }
        cell?.selectionStyle = .none

        while cell!.contentView.subviews.last != nil {
            cell!.contentView.subviews.last?.removeFromSuperview()
        }
        
        return cell!
    }
    
    // MARK: - 属性
    /// 启用下拉刷新
    public var isEnableRefresh: Bool = true {
        didSet {
            if isEnableRefresh {
                tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
            }else {
                tableView.mj_header = nil
            }
        }
    }
    
    /// 启用上拉加载更多
    public var isEnableLoadingMore: Bool = false {
        didSet {
            if isEnableLoadingMore {
                tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
            }else {
                tableView.mj_footer = nil
            }
        }
    }
    
    // MARK: - 公共方法
    /// 下拉刷新
    @objc open func refreshData(){
        pageNo = 1
        getDataSource()
    }
    
    /// 上拉加载更多
    @objc func loadMoreData(){
        pageNo += 1
        getDataSource()
    }
    
    /// 调用接口获取数据
    open func getDataSource() {
        
    }
    
    /// 取消MJRefresh加载动画
    @objc func cancelRefreshLoading() {
        if tableView.mj_header?.isRefreshing ?? false {
            tableView.mj_header?.endRefreshing()
        }
        
        if tableView.mj_footer?.isRefreshing ?? false {
            tableView.mj_footer?.endRefreshing()
        }
    }

    // MARK: - UITableViewDataSource
    open func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - UITableViewDelegate
    open func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to: #selector(getter: UITableViewCell.separatorInset)) {
            cell.separatorInset = edgeInsets
        }

        if cell.responds(to: #selector(getter: UIView.layoutMargins)) {
            cell.layoutMargins = edgeInsets
        }

        if cell.responds(to: #selector(getter: UIView.preservesSuperviewLayoutMargins)) {
            cell.preservesSuperviewLayoutMargins = false
        }
    }
    
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
