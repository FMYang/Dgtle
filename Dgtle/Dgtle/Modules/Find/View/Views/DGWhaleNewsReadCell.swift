//
//  DGWhaleNewsReadCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhaleNewsReadCell: UITableViewCell, DGWhaleNewsProtocol {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var readingNumLabel: UILabel!
    @IBOutlet weak var readingUnitLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        maskImageView.round(4, size: CGSize(width: screen_width-40, height: 180))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(item: DGWhaleNewsItem) {
        authorLabel.text = item.author
        timeLabel.text = item.dateline
        typeLabel.text = "鲸闻·" + (item.type_name ?? "")
        likeLabel.text = item.recommend_add
        commentLabel.text = String(item.comment_num ?? 0)
        readingNumLabel.text = item.reading_num
        readingUnitLabel.text = item.reading_unit
        
        avatarView.sp.setImageWithRounded(path: item.avatar,
                                          cornerRadius: 20,
                                          targetSize: CGSize(width: 40, height: 40))
        coverImageView.sp.setImageWithCrop(path: item.cover_name ?? "",
                                           radius: 4)

    }
}
