//
//  DGHomeListCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/23.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

enum DGHomeCellType: String {
    case news
    case article
    case article_topic
    case group_topic
    case group
    case news_read
    case word
}

protocol DGHomeCellProtocol {
    func configCell(model: DGHomeListItem)
}

class DGHomeListCell {
    static func cell(tableView: UITableView, type: DGHomeCellType, indexPath: IndexPath) -> DGHomeCellProtocol {
        switch type {
        case .news:
            return tableView.sp.dequeueReuseCell(DGHomeNewsCell.self, indexPath: indexPath)
        case .article:
            return tableView.sp.dequeueReuseCell(DGHomeArticleCell.self, indexPath: indexPath)
        case .article_topic, .group_topic:
            return tableView.sp.dequeueReuseCell(DGHomeArticleTopicCell.self, indexPath: indexPath)
        case .group:
            return tableView.sp.dequeueReuseCell(DGHomeGroupCell.self, indexPath: indexPath)
        case .news_read:
            return tableView.sp.dequeueReuseCell(DGHomeNewsReadCell.self, indexPath: indexPath)
        case .word:
            return tableView.sp.dequeueReuseCell(DGHomeWordCell.self, indexPath: indexPath)
        }
    }
}
