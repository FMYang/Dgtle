//
//  TDRefreshFooter.swift
//  MJRefresh_Test
//
//  Created by 杨方明 on 2017/11/7.
//  Copyright © 2017年 杨方明. All rights reserved.
//

import UIKit
import MJRefresh

public enum FooterStyle {
    case normal         // 默认loading样式(左边图片，右边文字)
    case onlyImage      // 自定义样式-只有图片
}

class TDRefreshNormalFooter: MJRefreshAutoFooter{ //MJRefreshBackFooter {

    private var footerIdleText: String = ""
    private var footerRefreshingText: String = ""
    private var footerReleaseText: String = ""
    private var footerNoMoreText: String = ""
    private var footerThemeColor: UIColor? = .lightGray
    private var footerStyle: FooterStyle = .normal

    private var textWidthConstraint: NSLayoutConstraint?

    public lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    public lazy var loading: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .gray)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - 重写方法
    // MARK: - 在这里做一些初始化配置（比如添加子控件）
    override func prepare() {
        super.prepare()

        self.mj_h = 50.0

        // 添加子视图
        self.setupViews()
    }
    
    func setupViews() {
        switch footerStyle {
        case .normal:
            self.addSubview(textLabel)
            self.addSubview(loading)
        case .onlyImage:
            self.addSubview(loading)
        }
    }

    // MARK: - 在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()
                
        switch footerStyle {
        case .normal:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[loading(==20)]-10-[textLabel]", options: [], metrics: nil, views: ["loading": loading, "textLabel": textLabel]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loading(==20)]", options: [], metrics: nil, views: ["loading": loading]))
            self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0))
        case .onlyImage:
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[loading(==20)]", options: [], metrics: nil, views: ["loading": loading]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loading(==20)]", options: [], metrics: nil, views: ["loading": loading]))
            self.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        }
        
        textLabel.textColor = footerThemeColor
        loading.color = footerThemeColor

        
    }

    override func updateConstraints() {
        super.updateConstraints()

        textLabel.sizeToFit()
        let width = textLabel.frame.size.width

        if let constraint = textWidthConstraint {
            self.removeConstraint(constraint)
        }

        textWidthConstraint = NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
    }

    // MARK: - 监听scrollView的contentOffset改变
    override func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }

    // MARK: - 监听scrollView的contentSize改变
    override func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }

    // MARK: - 监听scrollView的拖拽状态改变
    override func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

    // MARK: - 监听控件的刷新状态
    override var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                if footerStyle == .normal {
                    textLabel.text = footerIdleText
                }
                loading.stopAnimating()
            case .pulling:
                if footerStyle == .normal {
                    textLabel.text = footerReleaseText
                }
                loading.startAnimating()
            case .refreshing:
                if footerStyle == .normal {
                    textLabel.text = footerRefreshingText
                }
                loading.startAnimating()
            case .noMoreData:
                if footerStyle == .normal {
                    textLabel.text = footerNoMoreText
                }
                loading.stopAnimating()
            default:
                break;
            }

            self.updateConstraints()
        }
    }

    public func configFooter(idleText: String?,
                      refreshingText: String?,
                      releaseToPulling: String?,
                      noMoreText: String?,
                      themeColor: UIColor?,
                      style: FooterStyle?) {
        footerStyle = style ?? .normal
        footerIdleText = idleText ?? "上拉加载更多"
        footerRefreshingText = refreshingText ?? "加载中..."
        footerReleaseText = releaseToPulling ?? "释放加载更多"
        footerNoMoreText = noMoreText ?? "没有更多"
        footerThemeColor = themeColor
    }
}
