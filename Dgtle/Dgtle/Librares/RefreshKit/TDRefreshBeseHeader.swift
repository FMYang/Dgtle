//
//  TDRefreshBeseHeader.swift
//  MJRefresh
//
//  Created by 杨方明 on 2017/12/18.
//

import UIKit
import MJRefresh

public enum HeaderStyle {
    case normal         // 默认loading样式
    case imageOnLeft    // 自定义样式-左边图片，右边文字
    case imageOnTop     // 自定义样式-上面图片，下面文字
    case imageOnBottom  // 自定义样式-上面文字，下面图片
    case imageOnRight   // 自定义样式-右边图片，左边文字
    case onlyImage      // 自定义样式-只有图片
    case onlyText       // 自定义样式-只有文字
}

typealias RefreshBlock = () -> Void

open class TDRefreshBeseHeader {

    public static func configHeader(style: HeaderStyle,
                                    idleText: String?,
                                    pullingText: String?,
                                    refreshingText: String?,
                                    endRefershText: String?,
                                    animations: [UIImage]?,
                                    themeColor: UIColor?,
                                    imageSize: CGSize,
                                    animationDuration: TimeInterval,
                                    refreshingBlock: @escaping () -> Void) -> MJRefreshHeader {

            switch style {
            case .normal:
                let header: TDRefreshNormalHeader = TDRefreshNormalHeader(refreshingBlock: {
                    refreshingBlock()
                })
                header.configHeader(idleText: idleText,
                                    refreshingText: refreshingText,
                                    releaseToPulling: pullingText,
                                    endRefershText: endRefershText,
                                    themeColor: themeColor)
                return header
            case .imageOnLeft, .imageOnTop, .imageOnRight, .imageOnBottom, .onlyImage, .onlyText:
                let header: TDRefreshAnimalHeader = TDRefreshAnimalHeader(refreshingBlock: {
                    refreshingBlock()
                })
                header.configHeader(idleText: idleText,
                                    refreshingText: refreshingText,
                                    releaseToPulling: pullingText,
                                    endRefershText: endRefershText,
                                    animations: animations,
                                    themeColor: themeColor,
                                    style: style,
                                    imageSize: imageSize,
                                    animationDuration: animationDuration)
                return header
            }
    }

}
