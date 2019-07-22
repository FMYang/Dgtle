//
//  UITableView+Refresh.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

private let animations = (1...10).map { return UIImage(named: String.init(format: "whale%d", $0))! }

extension NamespaceWrapper where Base: TDRefreshTableView {
    func addHeader() {
        wrappedValue.addHeaderRefresh(style: .onlyImage,
                                      animations: animations,
                                      imageSize: CGSize(width: 40, height: 50),
                                      animationDuration: 2.0)

    }
    
    func addFooter() {
        wrappedValue.addFooterRefresh(style: .onlyImage)

    }
}

extension NamespaceWrapper where Base: TDRefreshCollectionView {
    func addHeader() {
        wrappedValue.addHeaderRefresh(style: .onlyImage,
                                      animations: animations,
                                      imageSize: CGSize(width: 40, height: 50),
                                      animationDuration: 2.0)
        
    }
    
    func addFooter() {
        wrappedValue.addFooterRefresh(style: .onlyImage)
        
    }
}

