//
//  UIImage+Round.swift
//  iGithub
//
//  Created by yfm on 2019/1/7.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    func rounded(cornerRadius: Double) -> UIImage {
        let rect = CGRect(origin: .zero, size: self.size)
        UIGraphicsBeginImageContext(self.size)
        UIBezierPath(roundedRect: rect, cornerRadius: rect.size.height/2).addClip()
        self.draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

extension UIImage {
    
    /// 裁剪图片
    ///
    /// - Parameter toSize: 目标图宽高
    /// - Returns: 裁剪后的图片
    @objc func crop(toSize: CGSize) -> UIImage {
        guard toSize != .zero else { return UIImage(named: "default")! }
        
        // 原图宽高比
        let imageRatio = size.width / size.height
        // 目标图宽高比
        let ratio = toSize.width / toSize.height
        
        var newSize:CGSize!
        if imageRatio > ratio {
            newSize = CGSize(width: size.height * ratio, height: size.height)
        } else {
            newSize = CGSize(width: size.width, height: size.width / ratio)
        }
        
        /// 图片绘制区域
        let originx = (newSize.width - size.width ) / 2.0
        let originy = (newSize.height - size.height ) / 2.0
        let rect = CGRect(x: originx, y: originy, width: size.width, height: size.height)
        
        /// 绘制并获取最终图片
        UIGraphicsBeginImageContext(newSize)
        draw(in: rect)
        let cropImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return cropImage!
    }
}
