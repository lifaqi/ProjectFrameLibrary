//
//  SWYWaterfallsFlowLayout.swift
//  ProjectFrameSwift
//
//  Created by 李发起 on 2022/12/28.
//

import UIKit

@objc protocol SWYWaterfallsFlowLayoutDeleaget: NSObjectProtocol {
    /// 每个item的高度
    func waterfallsFlowLayout(waterfallsFlowLayout: SWYWaterfallsFlowLayout, indexPath: IndexPath, itemWidth: CGFloat) -> CGFloat
    
    /// 有多少列
    func columnCountInWaterfallsFlowLayout(waterfallsFlowLayout: SWYWaterfallsFlowLayout) -> NSInteger
}

public class SWYWaterfallsFlowLayout: UICollectionViewFlowLayout {
    /// 代理
    weak var delegate: SWYWaterfallsFlowLayoutDeleaget?
    
    /// 列数
    var columnCount = 2
    
    /// 存放所有的布局属性
    fileprivate lazy var attrsArr: [UICollectionViewLayoutAttributes] = []
    
    fileprivate lazy var columnHeights: [CGFloat] = Array(repeating: self.sectionInset.top, count: columnCount)
    
    var contentHeight: CGFloat = 0
    
    // MARK: - 初始化
    public override func prepare() {
        super.prepare()
        
        if delegate != nil {
            columnCount = delegate!.columnCountInWaterfallsFlowLayout(waterfallsFlowLayout: self)
        }
        
        // 计算每个 Cell 的宽度
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(columnCount - 1)) / CGFloat(columnCount)
        // Cell 数量
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        // 最小高度索引
        var minHeightIndex = 0
        // 遍历 item 计算并缓存属性
        for i in attrsArr.count ..< itemCount {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 获取动态高度
            let itemHeight = delegate?.waterfallsFlowLayout(waterfallsFlowLayout: self, indexPath: indexPath, itemWidth: itemWidth)
            
            // 找到高度最短的那一列
            let value = columnHeights.min()
            // 获取数组索引
            minHeightIndex = columnHeights.firstIndex(of: value!)!
            // 获取该列的 Y 坐标
            var itemY = columnHeights[minHeightIndex]
            // 判断是否是第一行，如果换行需要加上行间距
            if i >= columnCount {
                itemY += minimumInteritemSpacing
            }
            
            // 计算该索引的 X 坐标
            let itemX = sectionInset.left + (itemWidth + minimumInteritemSpacing) * CGFloat(minHeightIndex)
            // 赋值新的位置信息
            attr.frame = CGRect(x: itemX, y: itemY, width: itemWidth, height: CGFloat(itemHeight!))
            // 缓存布局属性
            attrsArr.append(attr)
            // 更新最短高度列的数据
            columnHeights[minHeightIndex] = attr.frame.maxY
        }
        contentHeight = columnHeights.max()! + sectionInset.bottom
    }
}

extension SWYWaterfallsFlowLayout {
    
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 返回相交的区域
        return attrsArr.filter {
            $0.frame.intersects(rect)
        }
    }
    
    public override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width, height: contentHeight)
    }
}
