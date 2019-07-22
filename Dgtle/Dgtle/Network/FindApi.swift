//
//  FindApi.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

/// 发现模块api
///
/// - banner: 鲸图banner
/// - picture: 鲸图
/// - news: 鲸闻
/// - community: 社区
/// - idle: 闲置
enum FindApi {
    case banner
    case picture(page: Int)
    case news(page: Int)
    case community(page: Int)
    case idle(page: Int)
}

extension FindApi: DGTarget {
    var baseURL: URL {
        switch self {
        case .banner:
            return URL(string: "https://api.yii.dgtle.com/v2/whale-picture-special/home?version=3.9.6")!
        case .picture(let page):
            return URL(string: "https://api.yii.dgtle.com/v2/whale-picture/list?page=\(page)&dateline=0&version=3.9.6&sift=digest&perpage=20")!
        case .news(let page):
            return URL(string: "https://api.yii.dgtle.com/v2/app/news?version=3.9.6&dateline=0&page=\(page)&perpage=20&setup=1")!
        case .community(let page):
            return URL(string: "https://api.yii.dgtle.com/v2/app/community?page=\(page)&dateline=0&order=dateline&version=3.9.6&setup=1&perpage=20")!
        case .idle(let page):
            return URL(string: "https://api.yii.dgtle.com/v2/trade?page=\(page)&dateline=0&version=3.9.6&setup=1&perpage=20")!
        }
    }
    
    var path: String {
        return ""
    }
}
