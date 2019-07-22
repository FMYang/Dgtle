//
//  DGWaterfallFlowLayout.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

/// 瀑布流布局
class DGWaterfallFlowLayout: UICollectionViewFlowLayout {
    var columns = 2
    var delegate: UICollectionViewDelegateFlowLayout?
    var cellCounts: Int = 0
    var columnHeightList: [Float] = []
    var attributesDict: [String: IndexPath] = [:]
    
    override func prepare() {
        super.prepare()
        columnHeightList.removeAll()
        attributesDict.removeAll()
        delegate = collectionView?.delegate as? UICollectionViewDelegateFlowLayout
        
        cellCounts = collectionView?.numberOfItems(inSection: 0) ?? 0
        if cellCounts == 0 { return }
        
        // 设置每列默认高度为0
        for _ in 0..<columns {
            columnHeightList.append(0)
        }
        
        for i in 0..<cellCounts {
            layoutItem(at: IndexPath(item: i, section: 0))
        }
    }
    
    //此方法会多次调用，为每个cell布局
    public func layoutItem(at indexPath: IndexPath) {
        if cellCounts == 0 { return }
        
        //通过协议得到cell的间距
        let edgeInsets = delegate?.collectionView!(collectionView!, layout: self, insetForSectionAt: indexPath.row)
        
        //拿到每个单元格的高度
        let cellSize = delegate?.collectionView!(collectionView!, layout: self, sizeForItemAt: indexPath)
        
        //找出高度最小的列
        var columnIndex: Int = 0
        var shortHeight = columnHeightList[columnIndex]
        for i in 0..<columnHeightList.count {
            let height = columnHeightList[i]
            if height < shortHeight {
                shortHeight = height
                columnIndex = i
            }
        }
        
        //这是最小列的高度
        let top = columnHeightList[columnIndex]
        
        //重新计算出cell的frame
        let frame = CGRect(x: (edgeInsets?.left)! + CGFloat(columnIndex) * ((edgeInsets?.left)! + cellSize!.width),
                           y: CGFloat(top) + (edgeInsets?.top)!,
                           width: cellSize!.width,
                           height: cellSize!.height)
        
        //将重新计算的列高加入存起来
        columnHeightList[columnIndex] = Float(CGFloat(top) + (edgeInsets?.top)! + cellSize!.height)
        
        //每个cell对应的indexPath放到attributesInDict中，key是frame
        let frameStrKey = NSCoder.string(for: frame)
        attributesDict[frameStrKey] = indexPath
    }
    
    //返回cell的布局属性信息，如果忽略传入的rect一次性将所有的cell布局信息返回，图片过多时性能会很差
    public override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var array = Array<UICollectionViewLayoutAttributes>()
        let indexPaths = indexPathOfItem(rect: rect)
        for indexpath in indexPaths {
            let layoutAttributes = layoutAttributesForItem(at: indexpath)
            array.append(layoutAttributes!)
        }
        return array
    }
    
    //为每个cell布局完毕后，需要实现这个方法， 传入frame，返回的时cell的信息
    //传入当前可见cell的rect，视图滑动时调用
    private func indexPathOfItem(rect: CGRect) -> [IndexPath] {
        var array = Array<IndexPath>()
        for (keyRect, _) in attributesDict {
            let cellRect = NSCoder.cgRect(for: keyRect)
            if rect.intersects(cellRect) {
                let indexPath = attributesDict[keyRect]
                array.append(indexPath!)
            }
        }
        return array
    }
    
    //把重新计算的frame赋值给cell
    public override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        for (keyRect, _) in attributesDict {
            if attributesDict[keyRect]?.compare(indexPath) == .orderedSame {
                attributes.frame = NSCoder.cgRect(for: keyRect)
            }
        }
        return attributes
    }
    
    //最后还要实现这个方法，返回collectionView内容的大小
    //只需要遍历前面创建的存放列高的数组得到列最高的一个作为高度返回就可以了
    public override var collectionViewContentSize: CGSize {
        if cellCounts == 0 { return .zero }
        
        var size = collectionView?.frame.size
        var maxHeight = columnHeightList[0]

        //找到最高的列的高度
        for i in 0..<columnHeightList.count {
            let colHeight = columnHeightList[i]
            if colHeight > maxHeight {
                maxHeight = colHeight
            }
        }
        size?.height = CGFloat(maxHeight)
        return size!
    }
    
}
