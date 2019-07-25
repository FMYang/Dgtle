//
//  DGArticleDetailModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/26.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

struct DGArticleModel: HandyJSON {
    var timestamp: TimeInterval?
    var returnData: DGArticleReturnData?
}

struct DGArticleReturnData: HandyJSON {
    var articledata: DGArticleData?
    var article_content: DGArticleContent?
    var commentlist: [String: String]?
    var catdata: DGCatData?
}

struct DGArticleData: HandyJSON {
    var title: String?
    var username: String?
    var pic: String?
    var author: String?
    var authorid: String?
    var summary: String?
    var width: Double?
    var height: Double?
}

struct DGArticleContent: HandyJSON {
    var content: String?
    var dateline: TimeInterval?
}

struct DGCatData: HandyJSON {
    var catname: String?
}
