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
    var commentlist: [String: DGCommentModel]?
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
    var bio: String?
}

struct DGArticleContent: HandyJSON {
    var content: String?
    var dateline: TimeInterval?
}

struct DGCatData: HandyJSON {
    var catname: String?
}

/*{
 "pid": "8803977",
 "fid": "2",
 "tid": "1500951",
 "first": "0",
 "author": "eonhzd",
 "authorid": "86383",
 "subject": "",
 "dateline": "1564117998",
 "message": "2399的魅族16s<img class=\"expression\" src=\"static/image/smiley/default/01.gif\" smilieid=\"101\" border=\"0\" alt=\"\" />",
 "useip": "210.34.32.133",
 "invisible": "0",
 "anonymous": "0",
 "usesig": "0",
 "htmlon": "0",
 "bbcodeoff": "-1",
 "smileyoff": "0",
 "parseurloff": "0",
 "attachment": "0",
 "rate": "0",
 "ratetimes": "0",
 "status": "0",
 "tags": "0",
 "comment": "0",
 "replycredit": "0",
 "position": "2",
 "uid": "86383",
 "username": "eonhzd",
 "cid": "8803977"
 }*/

struct DGCommentModel: HandyJSON {
    var author: String?
    var authorid: String?
    var dateline: TimeInterval?
    var message: String?
    var pid: String?
}
