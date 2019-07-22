//
//  DGWhaleNewsModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

struct DGWhaleNewsModel: HandyJSON {
    var list: [DGWhaleNewsItem]?
}

/*
 {
 "fid": "160",
 "author": "DGtle丨尾巴君",
 "tid": "1498574",
 "authorid": "945520",
 "dateline": "1563673125",
 "typeid": "388",
 "recommend_add": "12",
 "replies": "11",
 "subject": "——人类登月五十年",
 "type_name": "每日一言",
 "type": "word",
 "comment_num": 18,
 "avatar": "http://www.dgtle.com/uc_server/avatar.php?uid=945520",
 "cover_name": "http://s1.dgtle.com/forum/201907/21/093841uwwj13ksznljtzj0.jpg",
 "pic_from": "",
 "message": "这是个人的一小步，却是人类的一大步。That's one small step for a man, one giant leap for mankind."
 }
 */
struct DGWhaleNewsItem: HandyJSON {
    var fid: String?
    var author: String?
    var tid: String?
    var authorid: String?
    var dateline: String?
    var typeid: String?
    var recommend_add: String?
    var replies: String?
    var subject: String?
    var type_name: String?
    var type: String?
    var comment_num: Int?
    var avatar: String?
    var cover_name: String?
    var pic_from: String?
    var message: String?
    var reading_num: String?
    var reading_unit: String?
}
