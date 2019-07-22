//
//  DGMineEnum.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

enum DGMineHomeItemType {
    case userInfo
    case myCreation
    case myIdle
    case myCollect
    case draftBox
    case skin
    case download
    case advise
    case setting
    
    var title: String {
        switch self {
        case .userInfo:
            return "Hi~ 欢迎你！"
        case .myCreation:
            return "我的创作"
        case .myIdle:
            return "我的闲置"
        case .myCollect:
            return "我的收藏"
        case .draftBox:
            return "草稿箱"
        case .skin:
            return "个性皮肤"
        case .download:
            return "离线下载"
        case .advise:
            return "反馈建议"
        case .setting:
            return "设置"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .userInfo:
            return UIImage(named: "avatar")
        case .myCreation:
            return UIImage(named: "creation_new")
        case .myIdle:
            return UIImage(named: "shuaishuai_new")
        case .myCollect:
            return UIImage(named: "collection_new")
        case .draftBox:
            return UIImage(named: "setting_draft_new")
        case .skin:
            return UIImage(named: "skin_new")
        case .download:
            return UIImage(named: "download_new")
        case .advise:
            return UIImage(named: "suggest_new")
        case .setting:
            return UIImage(named: "setting_new")
        }
    }
}
