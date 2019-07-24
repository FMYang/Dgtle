//
//  HomeViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation
import SwiftyJSON

class DGHomeViewModel {

    /// 获取banner数据
    ///
    /// - Returns: banner模型集合
    func fetchBanner() -> Observable<[DGHomeBannerItem]> {
       return Network.request(HomeApi.banner)
            .asObservable()
            .map { response -> [DGHomeBannerItem] in
                let data = JSON(response.data)
                let blocklist = data["returnData"]["blocklist"]["274"].dictionaryValue
                var banners = [DGHomeBannerItem]()
                for value in blocklist.values {
                    var item = DGHomeBannerItem()
                    item.title = value["title"].stringValue
                    item.pic_url = value["pic_url"].stringValue
                    banners.append(item)
                }
                return banners
            }
    }
    
    /// 获取列表数据
    ///
    /// - Parameter page: 页码
    /// - Returns: 列表模型集合
    func fetchList(page: Int) -> Observable<DGHomeListModel?> {
       return Network.request(HomeApi.list(page: page))
                .asObservable()
                .mapObject(type: DGHomeListModel.self)
                .catchErrorJustReturn(nil)
    }
    
    /// 获取word数据
    ///
    /// - Returns: 列表模型集合
    func fetchWord() -> Observable<DGHomeListItem> {
        return Network.request(HomeApi.word)
            .asObservable()
            .map { response -> DGHomeListItem in
                let data = JSON(response.data)
                let list = data["list"]
                // 将word数据映射到DGHomeListItem
                var item = DGHomeListItem()
                item.title = list["message"].stringValue
                item.tid = list["tid"].stringValue
                item.dateline = list["dateline"].stringValue
                item.type = "word"
                item.cover_name = list["cover_name"].stringValue
                return item
            }
    }
    
    /// 获取word和列表数据
    ///
    /// - Parameter page: 页码
    /// - Returns: word和列表数据集合
    func fetchData(page: Int) -> Observable<[DGHomeListItem]> {
        let lists = fetchList(page: page)
        let word = fetchWord()
        
        return Observable.zip(lists, word)
            .flatMap() { data -> Observable<[DGHomeListItem]> in
                let (listModel, word) = data
                var list = listModel?.list ?? []
                if page == 1 {
                    // 第一页插入word数据在到集合第一个
                    list.insert(word, at: 0)
                }
                return Observable.from([list])
            }
    }
}
