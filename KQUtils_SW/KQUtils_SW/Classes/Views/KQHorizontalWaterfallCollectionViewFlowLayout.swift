//
//  KQHorizontalWaterfallCollectionViewFlowLayout.swift
//  KQUtils_SW
//
//  Created by 柯青 on 2017/12/22.
//  Copyright © 2017年 KQ. All rights reserved.
//

import UIKit

enum KQCollectionAlignModel {
    case left
    case center
    case right
}


/// 横向瀑布流
class KQHorizontalWaterfallCollectionViewFlowLayout: UICollectionViewFlowLayout {

    //MARK: - 属性
    /// 横向瀑布流的对齐方式(默认为左对齐）
    var alignModel:KQCollectionAlignModel = .left
    
    /// 布局属性列表
    fileprivate lazy var attributes:[UICollectionViewLayoutAttributes] = []
    
    //MARK: - 重写方法
    override func prepare() {
        super.prepare()
        
        self.initData()
    }
}


// MARK: - 自定义的方法
extension KQHorizontalWaterfallCollectionViewFlowLayout {
    fileprivate func initData(){
        var left:Int = -1
        var right:Int = -1
        var width:CGFloat = 0
        var section:Int = 0
        
        var lastX = self.collectionView?.kq_width ?? 0
        
        var updateAttributes:[UICollectionViewLayoutAttributes] = []
        updateAttributes.append(contentsOf: super.layoutAttributesForElements(in: self.collectionView?.frame ?? CGRect.zero) ?? [])
        
        for i in 0..<updateAttributes.count {
            let attr = updateAttributes[i]
            if attr.representedElementKind == nil {
                section = attr.indexPath.section
                if attr.frame.origin.x < lastX {
                    if left != -1 {
                        //处理上一行内容
                        updateAttributes = self.attributes(for: left, right: right, offset: self.callOffset(with: section, width: width), origin: updateAttributes)
                    
                    }
                    
                    let space = self.evaluatedMinimumInteritemSpacing(for: section)
                    
                    
                    left = i
                    lastX = attr.frame.origin.x + space
                    
                    let edgInset = self.evaluatedSectionInsert(for: section)
                    
                    width = edgInset.left + edgInset.right - space
                    
                }
                let space = self.evaluatedMinimumInteritemSpacing(for: section)
                
                lastX = attr.frame.origin.x + attr.frame.size.width + space;
                right = i;
                width += attr.frame.size.width + space;
            }
        }
        //确保最后一行更新
        if left != -1 {
            updateAttributes = self.attributes(for: left, right: right, offset: self.callOffset(with: section, width: width), origin: updateAttributes)
        }
        attributes = updateAttributes
    }
    
    
    //处理上一行的内容
    private func attributes(for left:Int,right:Int,offset:CGFloat,origin attrs:[UICollectionViewLayoutAttributes]) -> [UICollectionViewLayoutAttributes] {
        var currentOffset = offset
        
        var updateAttrList = attrs
        
        for i in left..<right {
            let attr = updateAttrList[i]
            var frame = attr.frame
            frame.origin.x = currentOffset
            attr.frame = frame
            let secion =  attr.indexPath.section
            
            currentOffset += frame.size.width + self.evaluatedMinimumInteritemSpacing(for:secion)
            updateAttrList[i] = attr
        }
        return updateAttrList
        
    }
    
    
    private func evaluatedMinimumInteritemSpacing(for section:Int) -> CGFloat {
        if self.collectionView?.delegate?.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:minimumInteritemSpacingForSectionAt:))) == true {
            let delegate = self.collectionView?.delegate as! UICollectionViewDelegateFlowLayout
            
            return delegate.collectionView!(self.collectionView!, layout: self, minimumLineSpacingForSectionAt: section)
        }
        return self.minimumLineSpacing
    }
    
    fileprivate func callOffset(with section:Int,width:CGFloat) -> CGFloat {
        var offset = self.evaluatedSectionInsert(for: section).left
        switch self.alignModel {
        case .left:
            offset = self.evaluatedSectionInsert(for: section).left
        case .center:
            offset += (self.collectionView?.kq_width ?? 0) - width
        default:
            offset += ((self.collectionView?.kq_width ?? 0) - width)/2
        }
        
        return offset
    }
    
    
    fileprivate func evaluatedSectionInsert(for item:Int) -> UIEdgeInsets {
        if self.collectionView?.delegate?.responds(to: #selector(UICollectionViewDelegateFlowLayout.collectionView(_:layout:insetForSectionAt:))) == true {
            let delegate = self.collectionView?.delegate as! UICollectionViewDelegateFlowLayout
            return delegate.collectionView!(self.collectionView!, layout: self, insetForSectionAt: item)
            
        }
        return self.sectionInset
    }
}
