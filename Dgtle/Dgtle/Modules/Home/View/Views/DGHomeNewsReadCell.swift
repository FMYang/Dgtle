//
//  DGHomeNewsReadCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/24.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeNewsReadCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var readingLabel: UILabel!
    @IBOutlet weak var readingUnitLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        maskImageView.round(4, size: CGSize(width: screen_width-40, height: 160))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DGHomeNewsReadCell: DGHomeCellProtocol {
    func configCell(model: DGHomeListItem) {
        titleLabel.text = model.title
        authorLabel.text = model.author
        recommendLabel.text = model.recommend_add
        commentLabel.text = model.replies
        typeLabel.text = "鲸闻·" + (model.type_name ?? "")
        readingLabel.text = model.reading_num
        readingUnitLabel.text = model.reading_unit
        
        avatarView.sp.setImageWithRounded(path: model.avatar ?? "",
                                          cornerRadius: Float(avatarView.bounds.size.height * 0.5),
                                          targetSize: avatarView.bounds.size)
        
        coverImageView.sp.setImageWithCrop(path: model.cover_name ?? "", radius: 4)
    }
    
}
