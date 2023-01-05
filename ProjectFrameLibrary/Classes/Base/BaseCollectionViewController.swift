//
//  BaseCollectionViewController.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/12/30.
//

import UIKit

private let CellIdentifier = "CollectionViewCell"

open class BaseCollectionViewController: BaseViewController {
    
    var pageNo = 1
    var pageSize = 20

    public lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: CellIdentifier)
        
        // 去掉状态栏
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never;
        }
        
        return collectionView
    }()
    
    override func mainNavView() {
        super.mainNavView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(cancelRefreshLoading), name: CancelRefreshLoading, object: nil)
        
        /// 启用MJRefresh
        self.isEnableRefresh = true
    }
    
    open override func initData() {
        
    }
    
    open override func setupView() {
        
    }
    
    open func setupCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        
        while cell.contentView.subviews.last != nil {
            cell.contentView.subviews.last?.removeFromSuperview()
        }
        
        return cell
    }
    
    // MARK: - 属性
    /// 默认启用MJRefresh
    public var isEnableRefresh: Bool = true {
        didSet {
            if isEnableRefresh {
                collectionView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshData))
                collectionView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreData))
            }else {
                collectionView.mj_header = nil
                collectionView.mj_footer = nil
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
        if collectionView.mj_header?.isRefreshing ?? false {
            collectionView.mj_header?.endRefreshing()
        }
        
        if collectionView.mj_footer?.isRefreshing ?? false {
            collectionView.mj_footer?.endRefreshing()
        }
    }

}

extension BaseCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
