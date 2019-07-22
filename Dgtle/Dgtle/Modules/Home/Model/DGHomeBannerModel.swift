//
//  DGHomeBannerModel.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

struct DGHomeBannerModel: HandyJSON {
    var items: [DGHomeBannerItem]?
}

struct DGHomeBannerItem: HandyJSON {
    var title: String?
    var pic_url: String?
}
