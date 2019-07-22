//
//  DGInterestNewViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGInterestNewViewModel {
    func fetchNewList(page: Int) -> Observable<[DGInterestItemProtocol]> {
        return Network.request(InterestApi.list(page: page))
            .asObservable()
            .map { response -> [DGInterestItemProtocol] in
                let data = JSON(response.data)
                let result = data["group_list"].arrayValue
                var newList = [DGInterestListItem]()
                result.forEach({ (json) in
                    let item = DGInterestListItem(json: json)
                    newList.append(item)
                })
                return newList
            }
    }
    
    func fetchHotList(page: Int) -> Observable<[DGInterestItemProtocol]> {
        return Network.request(InterestApi.hot(page: page))
            .asObservable()
            .map { response -> [DGInterestItemProtocol] in
                let data = JSON(response.data)
                let result = data["returnData"]["hotlist"].arrayValue
                var hotList = [DGInterestHotItem]()
                result.forEach({ (json) in
                    let item = DGInterestHotItem(json: json)
                    hotList.append(item)
                })
                return hotList
            }
    }
}
