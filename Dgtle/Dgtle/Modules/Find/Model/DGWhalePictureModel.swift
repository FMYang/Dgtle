//
//  DGWhaleImageModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation
/*
 {
 "wid": "63883",
 "content": "数字尾巴启动图，精选用户原创壁纸：GX1",
 "author": "尾巴设计中心",
 "authorid": "456874",
 "typeid": "8",
 "likenum": "20",
 "favnum": "2",
 "viewnum": "2974",
 "commentnum": "5",
 "dateline": "1563508883",
 "width": "1242",
 "height": "2688",
 "pic_url": "http://s1.dgtle.com/whaleimg/whale/20190719/4-20190719305f41c71b77923.jpg",
 "type": "科技与艺术",
 "islike": 0
 }
 */

struct DGWhalePictureModel: HandyJSON {
    var list: [DGWhalePictureItem]?
}

struct DGWhalePictureItem: HandyJSON {
    var wid: String?
    var content: String?
    var author: String?
    var authorid: String?
    var typeid: String?
    var likenum: String?
    var favnum: String?
    var viewnum: String?
    var commentnum: String?
    var dateline: String?
    var width: Double?
    var height: Double?
    var pic_url: String?
    var type: String?
    var islike: String?
}
