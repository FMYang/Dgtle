//
//  DGInterestCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit
import YYKit

protocol DGInterestCellDelegate: class {
    func didClickImage(selected: Int, at indexPath: IndexPath?, imageView: UIImageView)
}

class DGInterestCell: UITableViewCell {
    
    weak var delegate: DGInterestCellDelegate?
    var indexPath: IndexPath?
    var picViews = [UIImageView]()
    
    /// 头像
    lazy var avatarView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    /// 作者
    lazy var authorLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    /// 时间
    lazy var timeLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = UIColor(valueRGB: 0x999999)
        return view
    }()
    
    /// 标题
    lazy var titleLabel: YYLabel = {
        let view = YYLabel()
        view.numberOfLines = 0
        view.preferredMaxLayoutWidth = screen_width - 20
        return view
    }()
    
    /// 图片视图
    lazy var picContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - life cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        layoutCommonUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - method
    public func layoutCommonUI() {
        addSubview(avatarView)
        addSubview(authorLabel)
        addSubview(timeLabel)
        addSubview(titleLabel)
        addSubview(picContainerView)
        
        avatarView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
        
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarView.snp.top)
            make.left.equalTo(avatarView.snp.right).offset(15)
            make.height.equalTo(15)
            make.right.equalToSuperview().offset(-20)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(authorLabel.snp.left)
            make.top.equalTo(authorLabel.snp.bottom).offset(10)
            make.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(timeLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        
        picContainerView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(titleLabel.snp.left)
            make.right.equalTo(titleLabel.snp.right)
            make.bottom.equalToSuperview()
        }
    }
    
    public func configCell(item: DGInterestItemProtocol?) {
        // 标题
        var mapper = [String: UIImage]()
        // TODO: 读plist
        mapper["{:嗯!?:}"] = self.image(name: "1_109")

        let parser = YYTextSimpleEmoticonParser()
        parser.emoticonMapper = mapper
        
        let message = item?.message ?? ""
        
        // 过滤html
        let attributeString = try! NSMutableAttributedString(data: message.data(using: String.Encoding.unicode)!,
                                                             options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil)
        let linkRange = (attributeString.string as NSString).range(of: "查看全文")
        if linkRange.length > 0 {
            attributeString.replaceCharacters(in: linkRange, with: "")
        }
//        attributeString.addAttributes([NSAttributedString.Key.foregroundColor : UIColor.red], range: linkRange)
        
        // 设置行高
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        attributeString.addAttributes([NSAttributedString.Key.paragraphStyle : paragraphStyle], range: NSRange(location: 0, length: attributeString.length))
        
        attributeString.font = UIFont.systemFont(ofSize: 16)
        titleLabel.attributedText = attributeString
        titleLabel.textParser = parser
        
        // 其他
        authorLabel.text = item?.author
        timeLabel.text = item?.date
        
        avatarView.sp.setImageWithRounded(path: item?.avatar ?? "",
                                          cornerRadius: 20,
                                          targetSize: CGSize(width: 40, height: 40))
        
        // 图片
        let picUrls = item?.attachment?.values.map { return $0 }
        
        for i in 0..<picViews.count {
            let picUrl = picUrls?[i] ?? ""
            let view = picViews[i]
            view.sp.setImageWithCrop(path: picUrl)
        }
    }
    
    /// 获取emoji图片 TODO
    func image(name: String) -> UIImage {
        let bundle = Bundle(path: Bundle.main.path(forResource: "EmoKeyboard", ofType: "bundle") ?? "")
        let path = bundle?.path(forScaledResource: name, ofType: "png") ?? ""
        let data = NSData(contentsOfFile: path)
        let image = YYImage(data: data! as Data)!
        return image
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension DGInterestCell {
    static func dequenceCell(tableView: UITableView, style: DGInterestCellStyle, indexPath: IndexPath) -> DGInterestCell {
        switch style {
        case .style1:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle1.self, indexPath: indexPath)
        case .style2:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle2.self, indexPath: indexPath)
        case .style3:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle3.self, indexPath: indexPath)
        case .style4:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle4.self, indexPath: indexPath)
        case .style5:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle5.self, indexPath: indexPath)
        case .style6:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle6.self, indexPath: indexPath)
        case .style7:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle7.self, indexPath: indexPath)
        case .style8:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle8.self, indexPath: indexPath)
        case .style9:
            return tableView.sp.dequeueReuseCell(DGInterestCellStyle9.self, indexPath: indexPath)
        }
    }
}

extension DGInterestCell {
    @objc func clickImage(ges: UITapGestureRecognizer) {
        let view = ges.view as! UIImageView
        let index = view.tag
        self.delegate?.didClickImage(selected: index, at: indexPath, imageView: view)
    }
}

