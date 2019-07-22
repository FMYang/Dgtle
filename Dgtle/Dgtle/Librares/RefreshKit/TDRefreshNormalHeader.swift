//
//  TDRefreshNormalHeader.swift
//  MJRefresh
//
//  Created by 杨方明 on 2017/12/18.
//

import UIKit
import MJRefresh
class TDRefreshNormalHeader: MJRefreshHeader {

    private var headerIdleText: String = ""
    private var headerRefreshingText: String = ""
    private var headerReleaseText: String = ""
    private var headerEndRefreshText: String = ""
    private var footerThemeColor: UIColor?
    var oldState: MJRefreshState = .idle

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
        self.addSubview(textLabel)
        self.addSubview(loading)
    }

    // MARK: - 在这里设置子控件的位置和尺寸
    override func placeSubviews() {
        super.placeSubviews()

        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[loading(==20)]-10-[textLabel]", options: [], metrics: nil, views: ["loading": loading, "textLabel": textLabel]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[loading(==20)]", options: [], metrics: nil, views: ["loading": loading]))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: loading, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0))

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
                if oldState == .refreshing {
                    textLabel.text = headerEndRefreshText
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                        self.textLabel.text = self.headerIdleText
                    })
                } else {
                    textLabel.text = headerIdleText
                }
                loading.stopAnimating()
            case .pulling:
                textLabel.text = headerReleaseText
                loading.startAnimating()
            case .refreshing:
                textLabel.text = headerRefreshingText
                loading.startAnimating()
            default:
                break;
            }

            oldState = state
            self.updateConstraints()
        }
    }

    public func configHeader(idleText: String?,
                             refreshingText: String?,
                             releaseToPulling: String?,
                             endRefershText: String?,
                             themeColor: UIColor?) {
        headerIdleText = idleText ?? "上拉加载更多"
        headerRefreshingText = refreshingText ?? "加载中..."
        headerReleaseText = releaseToPulling ?? "释放加载更多"
        headerEndRefreshText = endRefershText ?? "加载中..."
        footerThemeColor = themeColor
    }

}
