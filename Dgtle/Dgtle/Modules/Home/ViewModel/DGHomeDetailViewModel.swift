//
//  DGHomeDetailViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGHomeDetailViewModel {
    func fetchDetail(aid: String) -> Observable<DGArticleModel?> {
        return  Network.request(HomeApi.detail(aid: aid))
            .asObservable()
            .mapObject(type: DGArticleModel.self)
    }
}
