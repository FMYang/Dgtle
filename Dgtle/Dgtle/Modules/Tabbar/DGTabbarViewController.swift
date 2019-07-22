//
//  DGTabbarViewController.swift
//  Dgtle
//
//  Created by yfm on 2019/7/13.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

enum ItemType {
    case home
    case interest
    case find
    case message
    case mine
    
    var itemTitle: String {
        switch self {
        case .home:
            return "首页"
        case .interest:
            return "兴趣"
        case .find:
            return "发现"
        case .message:
            return "消息"
        case .mine:
            return "我的"
        }
    }
    
    var itemNormalIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tab_home_normal")?.withRenderingMode(.alwaysOriginal)
        case .interest:
            return UIImage(named: "tab_interest_normal")?.withRenderingMode(.alwaysOriginal)
        case .find:
            return UIImage(named: "tab_find_normal")?.withRenderingMode(.alwaysOriginal)
        case .message:
            return UIImage(named: "tab_message_normal")?.withRenderingMode(.alwaysOriginal)
        case .mine:
            return UIImage(named: "tab_mine_normal")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    var itemSelectedIcon: UIImage? {
        switch self {
        case .home:
            return UIImage(named: "tab_home_selected")?.withRenderingMode(.alwaysOriginal)
        case .interest:
            return UIImage(named: "tab_interest_selected")?.withRenderingMode(.alwaysOriginal)
        case .find:
            return UIImage(named: "tab_find_selected")?.withRenderingMode(.alwaysOriginal)
        case .message:
            return UIImage(named: "tab_message_selected")?.withRenderingMode(.alwaysOriginal)
        case .mine:
            return UIImage(named: "tab_mine_selected")?.withRenderingMode(.alwaysOriginal)
        }
    }
    
    func getController() -> UIViewController {
        let item = UITabBarItem(title: itemTitle,
                                image: self.itemNormalIcon,
                                selectedImage: self.itemSelectedIcon)
        let vc: UIViewController
        switch self {
        case .home:
            vc = DGHomeViewController()
        case .interest:
            vc = DGInterestViewController()
        case .find:
            vc = DGFindViewController()
        case .message:
            vc = DGMessageViewController()
        case .mine:
            vc = DGMineViewController()
        }
        vc.tabBarItem = item
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.shadowImage = UIImage()
        nav.navigationBar.setBackgroundImage(UIImage(named: "nav_bar"), for: .default)
        return nav
    }
}

class DGTabbarViewController: UITabBarController {
    
    private let items: [ItemType] = [.home,
                                     .interest,
                                     .find,
                                     .message,
                                     .mine]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // fix: iOS12 TabbarItem jump then back bug
        self.tabBar.isTranslucent = false
        self.viewControllers = items.map { $0.getController() }
        appearance()
    }
    
    func appearance() {
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.gray], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)

        // 隐藏tabbar顶部线
        tabBar.clipsToBounds = true
    }
}
