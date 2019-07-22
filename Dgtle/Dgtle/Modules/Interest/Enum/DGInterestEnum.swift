//
//  DGInterestEnum.swift
//  Dgtle
//
//  Created by yfm on 2019/7/19.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

/// 兴趣列表cell类型
///
/// - style1: 一张图
/// - style2: 二张图
/// - style3: 三张图
/// - style4: 四张图
/// - style5: 五张图
/// - style6: 六张图
/// - style7: 七张图
/// - style8: 八张图
/// - style9: 九张图
enum DGInterestCellStyle: Int {
    case style1 = 1
    case style2 = 2
    case style3 = 3
    case style4 = 4
    case style5 = 5
    case style6 = 6
    case style7 = 7
    case style8 = 8
    case style9 = 9
}

/// 兴趣列表类型
///
/// - new: 最新
/// - hot: 最热
enum DGInterestListControllerType {
    case new
    case hot
    
    var title: String {
        switch self {
        case .new:
            return "最新"
        case .hot:
            return "最热"
        }
    }
}
