//
//  DGWhaleNewsViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGWhaleNewsViewModel {
    func fetchWhaleNews(page: Int) -> Observable<DGWhaleNewsModel?> {
        return Network.request(FindApi.news(page: page))
            .asObservable()
            .mapObject(type: DGWhaleNewsModel.self)
    }
}
