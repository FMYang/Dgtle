//
//  DGMessageViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/13.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

enum DGMessageListType {
    case comment
    case praise
    case privateMessage
    
    var title: String {
        switch self {
        case .comment:
            return "评论"
        case .praise:
            return "赞"
        case .privateMessage:
            return "私信"
        }
    }
}

class DGMessageViewController: UIViewController {
    
    var controllerTypes: [DGMessageListType] = [.comment, .praise, .privateMessage]
    
    lazy var titleView: DGInterestTitleView = {
        let titles = controllerTypes.map { return $0.title }
        let view = DGInterestTitleView(width: 210, titles: titles)
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavTitles()
    }
    
    func setNavTitles() {
        navigationItem.titleView = titleView
    }
}

extension DGMessageViewController: DGInterestTitleViewDelegate {
    func didSelected(index: Int) {
    }
}

