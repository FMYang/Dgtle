//
//  HomeApi.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation
import Moya

enum HomeApi {
    case banner
    case word
    case list(page: Int)
    case detail(aid: String)
}

extension HomeApi: DGTarget {
    var baseURL: URL {
        switch self {
        case .banner:
            return URL(string: "http://api.dgtle.com/api.php?actions=diydata&apikeys=DGTLECOM_APITEST1&bid=274&charset=UTF8&dataform=json&inapi=json&modules=portal&platform=ios&swh=480x800&timestamp=1563084540&token=b9e99427d666200fe8097ad4db7b51db&version=3.9.6")!
        case .word:
            return URL(string: "https://api.yii.dgtle.com/v2/app/word?version=3.9.6")!
        case let .list(page):
            return URL(string: "https://api.yii.dgtle.com/v2/app/home?version=3.9.6&ad=1&dateline=0&live=1&page=\(page)&perpage=18&setup=")!
        case let .detail(aid):
            return URL(string: "http://api.dgtle.com/api.php?actions=view&aid=\(aid)&apikeys=DGTLECOM_APITEST1&charset=UTF8&dataform=json&inapi=json&modules=portal&platform=ios&swh=480x800&timestamp=1563123498&token=772130315a9d6911fbeeef41c4c2aac1&version=3.9.6")!
        }
    }

    var params: [String : Any]? {
        return [:]
    }

    var path: String {
        return ""
    }
    
    var moyaMethod: Moya.Method {
        return .get
    }
}
