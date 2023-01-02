//
//  BaseTableViewController.swift
//  ProjectFrameSwift
//
//  Created by apple on 2021/5/17.
//

import UIKit

private let CellIdentifier = "TableViewCell"

open class BaseTableViewController: BaseNavigationController, UITableViewDataSource, UITableViewDelegate {
    
    var edgeInsets: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 15, bottom: 0, right: 0)
    
    // view
    lazy var tableView: UITableView = {
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
    
    override func initData() {
        
    }
    
    override func setupView() {
        
    }
    
    func setupCell() -> UITableViewCell {
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
    
    // MARK: - 公共方法
    @objc func refreshData(){
        
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
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
