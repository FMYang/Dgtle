//
//  InterestApi.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation
import Moya

enum InterestApi {
    // 最新banner
    case banner
    // 最新列表
    case list(page: Int)
    // 热门列表
    case hot(page: Int)
}

extension InterestApi: DGTarget {
    var baseURL: URL {
        switch self {
        case .banner:
            return URL(string: "http://api.dgtle.com/api.php?REQUESTCODE=63&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=json&platform=ios&swh=480x800&version=3.9.6")!
        case let .list(page):
            return URL(string: "https://api.yii.dgtle.com/v2/forum-group?page=\(page)&dateline=0&version=3.9.6&first_dateline=0&ad=1&perpage=20")!
        case let .hot(page):
            return URL(string: "http://api.dgtle.com/api.php?REQUESTCODE=62&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=json&page=\(page)&perpage=20&platform=ios&swh=480x800&version=3.9.6")!
        }
    }
    
    var params: [String : Any]? {
        switch self {
        case .banner, .list, .hot:
            return [:]
        }
    }
    
    var path: String {
        switch self {
        case .banner, .list, .hot:
            return ""
        }
    }
    
    var moyaMethod: Moya.Method {
        return .get
    }
}
