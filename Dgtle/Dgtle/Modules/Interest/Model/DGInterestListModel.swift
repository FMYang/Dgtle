//
//  DGInterestListModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

/*
 "tid": "1495178",
 "recommend_add": "45",
 "views": "0",
 "digest": "0",
 "replies": "0",
 "fid": "140",
 "subject": "硬盘里翻出...",
 "message": "硬盘里翻出来一张\r\n拍摄时间：2016年8月7日\r\n器材：NIKON D3+24-70/2.8G\r\n拍摄地点：上海人民英雄纪念塔边",
 "author": "wjhjeff",
 "authorid": "122351",
 "pid": "8761167",
 "dateline": "1563111605",
 "forum_name": "摄影控",
 "forum_icon": "http://s1.dgtle.com/group/13/group_140_pngico.png?1467289530",
 "avatar": "http://www.dgtle.com/uc_server/avatar.php?uid=122351",
 "date": "14 小时前",
 "attachment": {
 "6176299": "http://s1.dgtle.com/forum/201907/14/213958j13dck3c7fm13xpc.jpg"
 },
 "attach_count": 1,
 "post_comment_count": 0
 }
 */

/// 为什么要用协议，主要是适配最新列表接口和热门列表接口返回的字段不一致的问题，
/// 比如附件数量，最新列表是attach_count，热门列表是attachcount
/// 吐槽：这坑人的字段定义
/// 使用适配器模式搞定这坑人的问题
protocol DGInterestItemProtocol {
    var tid: String? { get set}
    var recommend_add: String? { get set}
    var views: String? { get set}
    var digest: String? { get set}
    var replies: String? { get set}
    var fid: String? { get set}
    var subject: String? { get set}
    var message: String? { get set}
    var author: String? { get set}
    var authorid: String? { get set}
    var pid: String? { get set}
    var dateline: String { get set}
    var forum_name: String? { get set}
    var forum_icon: String? { get set}
    var avatar: String? { get set}
    var date: String? { get set}
    var attachment: [String: String]? { get set}
    var attach_count: Int? { get set}
    var post_comment_count: Int? { get set}
}

struct DGInterestListItem: DGInterestItemProtocol {
    var tid: String?
    var recommend_add: String?
    var views: String?
    var digest: String?
    var replies: String?
    var fid: String?
    var subject: String?
    var message: String?
    var author: String?
    var authorid: String?
    var pid: String?
    var dateline: String
    var forum_name: String?
    var forum_icon: String?
    var avatar: String?
    var date: String?
    var attachment: [String: String]?
    var attach_count: Int?
    var post_comment_count: Int?
    
    init(json: JSON) {
        self.tid = json["tid"].stringValue
        self.recommend_add = json["recommend_add"].stringValue
        self.views = json["views"].stringValue
        self.digest = json["digest"].stringValue
        self.replies = json["replies"].stringValue
        self.fid = json["fid"].stringValue
        self.subject = json["subject"].stringValue
        self.message = json["message"].stringValue
        self.author = json["author"].stringValue
        self.authorid = json["authorid"].stringValue
        self.pid = json["pid"].stringValue
        self.dateline = json["dateline"].stringValue
        self.forum_name = json["forum_name"].stringValue
        self.forum_icon = json["forum_icon"].stringValue
        self.avatar = json["avatar"].stringValue
        self.date = String.timeStampToString(timeStamp: Double(self.dateline)!)
        self.attachment = json["attachment"].dictionaryObject as? [String : String]
        self.attach_count = json["attach_count"].intValue
        self.post_comment_count = json["post_comment_count"].intValue
    }
}


/*
 {
 "tid": "1497455",
 "fid": "140",
 "posttableid": "0",
 "typeid": "0",
 "sortid": "0",
 "readperm": "0",
 "price": "0",
 "author": "摄影师_24",
 "authorid": "385471",
 "subject": "20岁....",
 "dateline": "1563495711",
 "lastpost": "1563535967",
 "lastposter": "HDmaster",
 "views": "196",
 "replies": "11",
 "displayorder": "0",
 "highlight": "0",
 "digest": "0",
 "rate": "0",
 "special": "0",
 "attachment": "2",
 "moderated": "0",
 "closed": "0",
 "stickreply": "0",
 "recommends": "10",
 "recommend_add": "62",
 "recommend_sub": "0",
 "heats": "78",
 "status": "32",
 "isgroup": "1",
 "favtimes": "7",
 "sharetimes": "0",
 "stamp": "-1",
 "icon": "-1",
 "pushedaid": "0",
 "cover": "0",
 "replycredit": "0",
 "relatebytag": "0",
 "maxposition": "12",
 "message": "20岁.",
 "pid": "8777372",
 "sccount": "73",
 "summary": "20岁.",
 "forum_name": "摄影控",
 "forum_icon": "http://s1.dgtle.com/group/13/group_140_pngico.png?1467289530",
 "islike": "0",
 "attachcount": 9,
 "attachlist": {
 "6191438": "http://s1.dgtle.com/forum/201907/19/082142yuuai86nhiuir5g9.jpg",
 "6191439": "http://s1.dgtle.com/forum/201907/19/082143gophr5fiydixjzfi.jpg",
 "6191442": "http://s1.dgtle.com/forum/201907/19/082144l4b6o95gh5trgqsj.jpg",
 "6191443": "http://s1.dgtle.com/forum/201907/19/082145g10ix4yy4fdtkj1d.jpg",
 "6191444": "http://s1.dgtle.com/forum/201907/19/082146ujedyecdk6d6drde.jpg",
 "6191446": "http://s1.dgtle.com/forum/201907/19/082146zdb1icj7w7rrhbjj.jpg",
 "6191447": "http://s1.dgtle.com/forum/201907/19/082147xjwdjctn1vmcvwx3.jpg",
 "6191448": "http://s1.dgtle.com/forum/201907/19/082148rncq062o2bhz66nh.jpg",
 "6191449": "http://s1.dgtle.com/forum/201907/19/082149y5yzk11lhrss5z1y.jpg"
 },
 "postcommentcount": "0"
 }
 */


/// 这里手动解析，最新接口和热门接口返回的json结构也不一样，一个没有嵌套returnData，一个有
struct DGInterestHotItem: DGInterestItemProtocol {
    var tid: String?
    var recommend_add: String?
    var views: String?
    var digest: String?
    var replies: String?
    var fid: String?
    var subject: String?
    var message: String?
    var author: String?
    var authorid: String?
    var pid: String?
    var dateline: String
    var forum_name: String?
    var forum_icon: String?
    var avatar: String?
    var date: String?
    var attachment: [String : String]?
    var attach_count: Int?
    var post_comment_count: Int?
    
    init(json: JSON) {
        self.tid = json["tid"].stringValue
        self.recommend_add = json["recommend_add"].stringValue
        self.views = json["views"].stringValue
        self.digest = json["digest"].stringValue
        self.replies = json["replies"].stringValue
        self.fid = json["fid"].stringValue
        self.subject = json["subject"].stringValue
        self.message = json["message"].stringValue
        self.author = json["author"].stringValue
        self.authorid = json["authorid"].stringValue
        self.pid = json["pid"].stringValue
        self.dateline = json["dateline"].stringValue
        self.forum_name = json["forum_name"].stringValue
        self.forum_icon = json["forum_icon"].stringValue
        self.avatar = json["avatar"].stringValue
        self.date = String.timeStampToString(timeStamp: Double(self.dateline)!)

        /// 注意：下面几个字段和最新接口返回的不一样，这里为了适配，手动解析
        self.attachment = json["attachlist"].dictionaryObject as? [String : String]
        self.attach_count = json["attachcount"].intValue
        self.post_comment_count = json["postcommentcount"].intValue
        self.avatar = "http://www.dgtle.com/uc_server/avatar.php?uid=\(self.authorid ?? "")"
    }
    
}
