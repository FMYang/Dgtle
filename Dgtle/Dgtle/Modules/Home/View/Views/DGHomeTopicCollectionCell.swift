//
//  DGHomeTopicCollectionCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/24.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeTopicCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var maskImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 4
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(valueRGB: 0xf2f2f2).cgColor
    }
    
    func configCell(model: DGHomeListItem) {
        maskImageView.isHidden = false
        maskImageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)

        let urls = model.attachment?.values.map { return $0 }
        let url = urls?[0] ?? ""
        pictureView.sp.setImageWithCrop(path: url)
        
        avatarView.sp.setImageWithRounded(path: model.avatar ?? "",
                                          cornerRadius: Float(avatarView.bounds.size.height * 0.5),
                                          targetSize: avatarView.bounds.size)
        
        titleLabel.text = model.message
        authorLabel.text = model.author
    }
    
    func configCell(article: DGHomeTopicArticleItem) {
        maskImageView.isHidden = true
        pictureView.sp.setImageWithCrop(path: article.pic ?? "")
        titleLabel.text = article.summary
    }
}
