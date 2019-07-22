//
//  TDRefreshNormalHeader.swift
//  MJRefresh
//
//  Created by 杨方明 on 2017/12/18.
//

import UIKit
import MJRefresh

public class TDRefreshAnimalHeader: MJRefreshHeader {

    private var headerIdleText: String = ""
    private var headerRefreshingText: String = ""
    private var headerReleaseText: String = ""
    private var headerEndRefreshText: String = ""
    private var headerAnimations: [UIImage]? = nil
    private var headerStyle: HeaderStyle = .imageOnLeft
    private var headerImageSize: CGSize = .zero
    
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

    public lazy var animationView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - 重写方法
    // MARK: - 在这里做一些初始化配置（比如添加子控件）
    override public func prepare() {
        super.prepare()

        self.mj_h = 50.0

        self.setupViews()
    }

    // MARK: - 在这里设置子控件的位置和尺寸
    override public func placeSubviews() {
        super.placeSubviews()

        self.layout()
    }

    override public func updateConstraints() {
        if headerStyle == .imageOnLeft || headerStyle == .imageOnRight {
            textLabel.sizeToFit()
            let width = textLabel.frame.size.width

            if let constraint = textWidthConstraint {
                self.removeConstraint(constraint)
            }

            textWidthConstraint = NSLayoutConstraint(item: textLabel, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: width)
        }

        super.updateConstraints()
    }

    // MARK: - 监听scrollView的contentOffset改变
    override public func scrollViewContentOffsetDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentOffsetDidChange(change)
    }

    // MARK: - 监听scrollView的contentSize改变
    override public func scrollViewContentSizeDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewContentSizeDidChange(change)
    }

    // MARK: - 监听scrollView的拖拽状态改变
    override public func scrollViewPanStateDidChange(_ change: [AnyHashable : Any]!) {
        super.scrollViewPanStateDidChange(change)
    }

    // MARK: - 监听控件的刷新状态
    override public var state: MJRefreshState {
        didSet {
            switch state {
            case .idle:
                if headerStyle != .onlyImage {
                    if oldState == .refreshing {
                        textLabel.text = headerEndRefreshText
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                            self.textLabel.text = self.headerIdleText
                        })
                    } else {
                        textLabel.text = headerIdleText
                    }
                }
                if headerStyle != .onlyText {
                    animationView.stopAnimating()
                    animationView.image = headerAnimations?[0] ?? UIImage()
                }
            case .pulling:
                if headerStyle != .onlyImage {
                    textLabel.text = headerReleaseText
                }
                if headerStyle != .onlyText {
                    animationView.startAnimating()
                }
            case .refreshing:
                if headerStyle != .onlyImage {
                    textLabel.text = headerRefreshingText
                }
                if headerStyle != .onlyText {
                    animationView.startAnimating()
                }
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
                             animations: [UIImage]?,
                             themeColor: UIColor?,
                             style: HeaderStyle,
                             imageSize: CGSize,
                             animationDuration: TimeInterval) {
        headerIdleText = idleText ?? "上拉加载更多"
        headerRefreshingText = refreshingText ?? "加载中..."
        headerReleaseText = releaseToPulling ?? "释放加载更多"
        headerEndRefreshText = endRefershText ?? "加载中..."
        animationView.animationImages = animations
        headerAnimations = animations
        headerImageSize = imageSize
        headerStyle = style
        textLabel.textColor = themeColor
        animationView.animationDuration = animationDuration

        switch headerStyle {
        case .imageOnLeft, .imageOnRight:
            self.mj_h = headerImageSize.height + 20
        case .imageOnTop, .imageOnBottom:
            self.mj_h = headerImageSize.height + 50
        case .onlyText:
            self.mj_h = 40
        case .onlyImage:
            self.mj_h = headerImageSize.height + 20
        default:
            self.mj_h = 50
        }
    }

    func setupViews() {
        switch headerStyle {
        case .imageOnLeft, .imageOnRight, .imageOnTop, .imageOnBottom:
            self.addSubview(contentView)
            contentView.addSubview(textLabel)
            contentView.addSubview(animationView)
        case .onlyText:
            self.addSubview(contentView)
            contentView.addSubview(textLabel)
        case .onlyImage:
            self.addSubview(contentView)
            contentView.addSubview(animationView)
        default:
            break
        }
    }

    private func layout() {
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

        let metrics = ["imageWidth": headerImageSize.width, "imageHeight": headerImageSize.height]

        switch headerStyle {
        case .imageOnLeft:
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[animationView(==imageWidth)]-10-[textLabel]-10-|", options: [], metrics: metrics, views: ["animationView": animationView, "textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[animationView(==imageHeight)]", options: [], metrics: metrics, views: ["animationView": animationView]))
            contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0))
        case .imageOnRight:
            let metrics = ["imageWidth": headerImageSize.width, "imageHeight": headerImageSize.height]
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textLabel]-10-[animationView(==imageWidth)]-10-|", options: [], metrics: metrics, views: ["animationView": animationView, "textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[animationView(==imageHeight)]", options: [], metrics: metrics, views: ["animationView": animationView]))
            contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerY, relatedBy: .equal, toItem: textLabel, attribute: .centerY, multiplier: 1, constant: 0))
        case .imageOnTop:
            self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0))
            self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))

            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[animationView(==imageHeight)]-10-[textLabel(==20)]-10-|", options: [], metrics: metrics, views: ["animationView": animationView, "textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textLabel]-10-|", options: [], metrics: metrics, views: ["textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[animationView(==imageWidth)]", options: [], metrics: metrics, views: ["animationView": animationView]))

            contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
        case .imageOnBottom:
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[textLabel(==20)]-10-[animationView(==imageHeight)]-10-|", options: [], metrics: metrics, views: ["animationView": animationView, "textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textLabel]-10-|", options: [], metrics: metrics, views: ["textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[animationView(==imageWidth)]", options: [], metrics: metrics, views: ["animationView": animationView]))

            contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
            contentView.addConstraint(NSLayoutConstraint(item: textLabel, attribute: .centerX, relatedBy: .equal, toItem: contentView, attribute: .centerX, multiplier: 1, constant: 0))
        case .onlyText:
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[textLabel]-10-|", options: [], metrics: nil, views: ["textLabel": textLabel]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[textLabel]-10-|", options: [], metrics: nil, views: ["textLabel": textLabel]))
        case .onlyImage:
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[animationView(==imageWidth)]-10-|", options: [], metrics: metrics, views: ["animationView": animationView]))
            contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[animationView(==imageHeight)]-10-|", options: [], metrics: metrics, views: ["animationView": animationView]))
        default:
            break
        }
    }

}


