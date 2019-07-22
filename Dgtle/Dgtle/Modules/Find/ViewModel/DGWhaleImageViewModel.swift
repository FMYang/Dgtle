//
//  DGWhaleImageViewModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

class DGWhaleImageViewModel {
    func fetchWhaleImage(page: Int) -> Observable<DGWhalePictureModel?> {
        return Network.request(FindApi.picture(page: page))
            .asObservable()
            .mapObject(type: DGWhalePictureModel.self)
    }
}
