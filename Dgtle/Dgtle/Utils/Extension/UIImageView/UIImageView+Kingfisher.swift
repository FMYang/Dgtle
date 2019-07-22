//
//  UIImageView+Kingfisher.swift
//  iGithub
//
//  Created by yfm on 2019/1/17.
//  Copyright © 2019年 com.yfm.www. All rights reserved.
//

import Foundation
import Kingfisher

var queue = DispatchQueue(label: "com.dgtle.cropQueue")

extension NamespaceWrapper where Base: UIImageView {
    
    /// 设置图片
    ///
    /// - Parameter path: 图片地址
    func setImage(path: String) {
        if let url = URL(string: path) {
            wrappedValue.kf.setImage(with: url,
                                     placeholder: UIImage(named: "default"),
                                     options: [],
                                     progressBlock: nil,
                                     completionHandler: nil)
        }
        
    }

    /// 设置按展示大小的比例裁剪之后的图片
    ///
    /// - Parameter path: 图片地址
    func setImageWithCrop(path: String) {
        if let url = URL(string: path) {
            wrappedValue.kf.setImage(with: url,
                                     placeholder: UIImage(named: "default"),
                                     options: [],
                                     progressBlock: nil) { (img, _, _, _) in
                                            let targetSize = self.wrappedValue.bounds.size
                                            queue.async {
                                                if img?.size != .zero {
                                                    let cropImage = img?.crop(toSize: targetSize)
                                                    DispatchQueue.main.async {
                                                        self.wrappedValue.image = cropImage
                                                    }
                                                }
                                        }

            }
        }
    }
    

    /// set image and rounded
    ///
    /// - Parameters:
    ///   - path: image path
    ///   - cornerRadius: radius
    ///   - targetSize: target size
    func setImageWithRounded(path: String?,
                             cornerRadius: Float,
                             targetSize: CGSize) {
        if let _path = path, let url = URL(string: _path) {
            let processor = RoundCornerImageProcessor(cornerRadius: CGFloat(cornerRadius), targetSize: targetSize)
            wrappedValue.kf.setImage(with: url,
                                     placeholder: nil,
                                     options: [.processor(processor),
                                               .cacheSerializer(FormatIndicatedCacheSerializer.png)])
        }
    }
}
