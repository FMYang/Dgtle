//
//  DGWhaleNewsCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

enum DGWhaleNewsStyle {
    case `default`
    case word
    case read
}

protocol DGWhaleNewsProtocol {
    func configCell(item: DGWhaleNewsItem)
}

class DGWhaleNewsCell {
    
    static func getType(name: String) -> DGWhaleNewsStyle {
        if name == "default" {
            return .default
        } else if name == "word" {
            return .word
        } else if name == "read" {
            return .read
        } else {
            return .default
        }
    }
    
    static func dequeueCell(tableView: UITableView, style: DGWhaleNewsStyle, indexPath: IndexPath) -> DGWhaleNewsProtocol {
        switch style {
        case .default:
            return tableView.sp.dequeueReuseCell(DGWhaleNewsDefaultCell.self, indexPath: indexPath) as DGWhaleNewsProtocol
        case .word:
            return tableView.sp.dequeueReuseCell(DGWhaleNewsWordCell.self, indexPath: indexPath) as DGWhaleNewsProtocol
        case .read:
            return tableView.sp.dequeueReuseCell(DGWhaleNewsReadCell.self, indexPath: indexPath) as DGWhaleNewsProtocol
        }
    }

}

