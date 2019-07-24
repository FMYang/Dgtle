//
//  UIImageView+Round.swift
//  Dgtle
//
//  Created by yfm on 2019/7/23.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

extension UIImageView {
    func round(radius: Double) {
        self.image = image?.rounded(cornerRadius: radius)
    }
}
