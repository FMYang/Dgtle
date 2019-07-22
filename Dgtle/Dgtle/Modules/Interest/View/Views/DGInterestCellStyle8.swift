//
//  DGInterestCellStyle1.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGInterestCellStyle8: DGInterestCell {

    let picWidth1 = (screen_width-30)/2
    let picWidth2 = (screen_width-40)/3
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layoutUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    // MARK: - mehod
    func layoutUI() {
        picViews = (0..<8).map { _ -> UIImageView in
            let img = UIImageView()
            img.isUserInteractionEnabled = true
            return img
        }
        
        var preView: UIImageView!
        for i in 0..<picViews.count {
            let view = picViews[i]
            view.tag = i
            let ges = UITapGestureRecognizer(target: self, action: #selector(clickImage(ges:)))
            view.addGestureRecognizer(ges)
            picContainerView.addSubview(view)
            
            if i == 0 {
                view.snp.makeConstraints { (make) in
                    make.left.top.equalToSuperview()
                    make.width.equalTo(picWidth1)
                    make.height.equalTo(160)
                }
            } else if i == 1 {
                view.snp.makeConstraints { (make) in
                    make.left.equalTo(preView.snp.right).offset(10)
                    make.width.height.equalTo(preView)
                    make.centerY.equalTo(preView)
                    make.right.equalToSuperview()
                }
            } else if i == 2 {
                view.snp.makeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.top.equalTo(preView.snp.bottom).offset(10)
                    make.width.height.equalTo(picWidth2)
                }
            } else if i == 3 {
                view.snp.makeConstraints { (make) in
                    make.left.equalTo(preView.snp.right).offset(10)
                    make.centerY.equalTo(preView)
                    make.width.height.equalTo(preView)
                }
            } else if i == 4 {
                view.snp.makeConstraints { (make) in
                    make.left.equalTo(preView.snp.right).offset(10)
                    make.centerY.equalTo(preView)
                    make.width.height.equalTo(picWidth2)
                    make.right.equalToSuperview()
                }
            } else if i == 5 {
                view.snp.makeConstraints { (make) in
                    make.left.equalToSuperview()
                    make.top.equalTo(preView.snp.bottom).offset(10)
                    make.width.height.equalTo(preView)
                    make.bottom.equalToSuperview()
                }
            } else if i == 6 {
                view.snp.makeConstraints { (make) in
                    make.left.equalTo(preView.snp.right).offset(10)
                    make.centerY.equalTo(preView)
                    make.width.height.equalTo(preView)
                }
            } else if i == 7 {
                view.snp.makeConstraints { (make) in
                    make.left.equalTo(preView.snp.right).offset(10)
                    make.centerY.equalTo(preView)
                    make.width.height.equalTo(preView)
                    make.right.equalToSuperview()
                }
            }
            
            preView = view
        }
        
    }
}
