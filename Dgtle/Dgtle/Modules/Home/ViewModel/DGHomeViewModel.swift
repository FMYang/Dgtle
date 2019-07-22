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
    
    func fetchList(page: Int) -> Observable<DGHomeListModel?> {
       return Network.request(HomeApi.list(page: page))
                .asObservable()
                .mapObject(type: DGHomeListModel.self)
                .catchErrorJustReturn(nil)
    }
}
