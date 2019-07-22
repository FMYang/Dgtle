//
//  DGHomeItemCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/14.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeItemCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    @IBOutlet weak var subTitleLable: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configCell(model: DGHomeListItem) {
        titleLabel.text = model.title
        subTitleLable.text = model.summary
        authorLabel.text = model.author
        recommendLabel.text = model.recommend_add
        commentLabel.text = model.comment_num
        typeLabel.text = model.type_name
        
        
        picImageView.sp.setImage(path: model.pic ?? "")
        
        avatarView.sp.setImageWithRounded(path: model.avatar ?? "",
                                          cornerRadius: Float(avatarView.bounds.size.height * 0.5),
                                          targetSize: avatarView.bounds.size)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor(valueRGB: 0xf2f2f2)
        self.selectedBackgroundView = selectedView
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
