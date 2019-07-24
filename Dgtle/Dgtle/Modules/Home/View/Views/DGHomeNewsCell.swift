//
//  DGHomeNewsCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/23.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeNewsCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var recomendLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension DGHomeNewsCell: DGHomeCellProtocol {    
    func configCell(model: DGHomeListItem) {
        titleLabel.text = model.title
        subjectLabel.text = model.summary
        authorLabel.text = model.author
        recomendLabel.text = model.recommend_add
        commentLabel.text = model.comment_num
        typeLabel.text = "鲸闻·" + (model.type_name ?? "")
        
        pictureView.sp.setImage(path: model.pic ?? "")
        
        avatarView.sp.setImageWithRounded(path: model.avatar ?? "",
                                          cornerRadius: Float(avatarView.bounds.size.height * 0.5),
                                          targetSize: avatarView.bounds.size)
    }
}
