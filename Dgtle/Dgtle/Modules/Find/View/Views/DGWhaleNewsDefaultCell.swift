//
//  DGWhaleNewsDefaultCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhaleNewsDefaultCell: UITableViewCell, DGWhaleNewsProtocol {
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(item: DGWhaleNewsItem) {
        authorLabel.text = item.author
        timeLabel.text = item.dateline
        typeLabel.text = "鲸闻·" + (item.type_name ?? "")
        titleLabel.text = item.subject
        messageLabel.text = item.message
        likeLabel.text = item.recommend_add
        commentLabel.text = String(item.comment_num ?? 0)
        
        avatarView.sp.setImageWithRounded(path: item.avatar,
                                          cornerRadius: 20,
                                          targetSize: CGSize(width: 40, height: 40))
        pictureView.sp.setImageWithCrop(path: item.cover_name ?? "")
    }
}
