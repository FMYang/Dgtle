//
//  UITableViewCell+init.swift
//  Dgtle
//
//  Created by yfm on 2019/7/16.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

extension UITableViewCell {
    static func swizzling_init() {
        self.aop_ExchangeInstanceSelector(originalSelector: #selector(self.init(style:reuseIdentifier:)),
                                          swizzledSelector: #selector(self.aop_init(style:reuseIdentifier:)),
                                          cls: UITableViewCell.self)
    }
    
    @objc func aop_init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        self.aop_init(style: style, reuseIdentifier: reuseIdentifier)
        
        print(String(describing: type(of: self)))
    }
}
