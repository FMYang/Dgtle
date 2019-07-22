//
//  DGHomeBannerCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit
import FSPagerView

class DGHomeBannerCell: FSPagerViewCell {
    lazy var imgView: UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imgView)
        imgView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
