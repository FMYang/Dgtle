//
//  UIView+Round.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import Foundation

extension UIView {
    
    /// view设置圆角
    ///
    /// - Parameter radius: 半径
    /// - Returns: 新的view
    func round(_ radius: Double, size: CGSize) {
        self.backgroundColor = .clear
        let imageView = UIImageView(image: rounded(cornerRadius: radius,
                                                   size: size))
        self.insertSubview(imageView, at: 0)
    }

    func rounded(cornerRadius: Double, size: CGSize) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContext(size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        context?.addPath(path.cgPath)
        self.draw(rect)
        let color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        context?.setFillColor(color.cgColor)
        context?.drawPath(using: .fill)
        context?.clip()
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

