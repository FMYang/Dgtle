//
//  DGHomeListModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

/*
 "author" : "巴尼乔生",
 "replies" : "3",
 "type" : "article",
 "comment_num" : 3,
 "catid" : "7",
 "special" : "0",
 "fid" : "2",
 "aid" : "29163",
 "dateline" : "1563091260",
 "type_name" : "其它",
 "tid" : "1493725",
 "authorid" : "49500",
 "title" : "巴尼乔生·我们爱地球",
 "summary" : "最初做这套壁纸的想法是看到网上一个视频，一群北极熊在堆满垃圾的雪地里寻找食物，看了之后心里的确很不舒服。",
 "recommend_add" : "16",
 "views" : "285",
 "pic" : "http:\/\/s1.dgtle.com\/portal\/201907\/12\/145707vb7ro0xcnwcawxnd.png",
 "url" : "",
 "avatar" : "http:\/\/www.dgtle.com\/uc_server\/avatar.php?uid=49500",
 "typeid" : "8"*/

struct DGHomeListModel: HandyJSON {
    var list: [DGHomeListItem]?
}

struct DGHomeListItem: HandyJSON {
    /// 作者
    var author: String?
    
    /// 类型
    var replies: String?
    
    /// 类型
    var type: String?
    
    /// 评论数
    var comment_num: String?
    
    /// catid
    var catid: String?
    
    /// special
    var special: String?
    
    /// fid
    var fid: String?
    
    /// 文章id
    var aid: String?
    
    /// 发布时间
    var dateline: String?
    
    /// 类型名
    var type_name: String?
    
    /// tid
    var tid: String?
    
    /// 作者id
    var authorid: String?
    
    /// 标题
    var title: String?
    
    /// 子标题
    var summary: String?
    
    /// 推荐数
    var recommend_add: String?
    
    /// 浏览量
    var views: String?
    
    /// 图片
    var pic: String?
    
    /// 链接
    var url: String?
    
    /// 作者头像
    var avatar: String?
    
    /// 类型id
    var typeid: String?
    
    var attach_count: Int?
    
    var attachment: [String: String]?
    
    var post_comment_count: String?
    
    var forum_name: String?
    
    var reading_unit: String?
    
    var reading_num: String?
    
    var cover_name: String?
    
    var message: String?
    
    var topic_group: DGHomeTopicGroupModel?
    
    var topic_article: DGHomeTopicArticleModel?
}

// 兴趣专题
struct DGHomeTopicGroupModel: HandyJSON {
    var list: [DGHomeListItem]?
}

// 文章专题
struct DGHomeTopicArticleModel: HandyJSON {
    var list: [DGHomeTopicArticleItem]?
}

// 文章专题item模型
struct DGHomeTopicArticleItem: HandyJSON {
    var title: String?
    var pic: String?
    var summary: String?
}
