//
//  DGHomeGroupCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/23.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeGroupCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var recommendLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension DGHomeGroupCell: DGHomeCellProtocol {
    func configCell(model: DGHomeListItem) {
        authorLabel.text = model.author
        recommendLabel.text = model.recommend_add
        commentLabel.text = model.replies
        typeLabel.text = "兴趣·" + (model.forum_name ?? "")
        
        avatarView.sp.setImageWithRounded(path: model.avatar ?? "",
                                          cornerRadius: Float(avatarView.bounds.size.height * 0.5),
                                          targetSize: avatarView.bounds.size)
        
        let picUrls = model.attachment?.values.map { return $0 } ?? []
        if picUrls.count == 1 {
            picImageView.isHidden = false
            leftImageView.isHidden = true
            rightImageView.isHidden = true
            picImageView.sp.setImageWithCrop(path: picUrls[0])
            titleLabel.text = model.message
        } else if picUrls.count > 2 {
            titleLabel.text = model.title
            picImageView.isHidden = true
            leftImageView.isHidden = false
            rightImageView.isHidden = false
            leftImageView.sp.setImageWithCrop(path: picUrls[0])
            rightImageView.sp.setImageWithCrop(path: picUrls[1])
        }
    }

}
