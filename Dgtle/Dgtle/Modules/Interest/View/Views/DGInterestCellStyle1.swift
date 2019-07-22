//
//  DGInterestCellStyle1.swift
//  Dgtle
//
//  Created by yfm on 2019/7/15.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGInterestCellStyle1: DGInterestCell {
        
    lazy var picView: UIImageView = {
        let view = UIImageView()
        view.isUserInteractionEnabled = true
        view.tag = 0
        let ges = UITapGestureRecognizer(target: self, action: #selector(clickImage(ges:)))
        view.addGestureRecognizer(ges)
        return view
    }()
    
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
    
    func layoutUI() {
        picViews.append(picView)
        picContainerView.addSubview(picView)
        picView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(250)
        }
    }    
}
