//
//  DGHomeDetailViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGHomeDetailViewModel {
    func fetchDetail(aid: String) -> Observable<String> {
        return  Network.request(HomeApi.detail(aid: aid))
            .asObservable()
            .map { response -> String in
                let data = JSON(response.data)
                let content = data["returnData"]["article_content"]["content"].stringValue
                return content
            }
    }
}
