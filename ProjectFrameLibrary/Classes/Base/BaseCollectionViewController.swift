//
//  BaseCollectionViewController.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/12/30.
//

import UIKit

private let CellIdentifier = "CollectionViewCell"

class BaseCollectionViewController: BaseNavigationController {

    lazy var collectionView: UICollectionView = {
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
    }
    
    override func initData() {
        
    }
    
    override func setupView() {
        
    }
    
    func setupCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier, for: indexPath)
        
        while cell.contentView.subviews.last != nil {
            cell.contentView.subviews.last?.removeFromSuperview()
        }
        
        return cell
    }
    
    // MARK: - 公共方法
    @objc func refreshData(){
        
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
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}
