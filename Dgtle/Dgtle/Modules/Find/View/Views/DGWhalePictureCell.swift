//
//  DGWhalePictureCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhalePictureCell: UICollectionViewCell {

    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .white
    }
    
    func config(item: DGWhalePictureItem) {
        let avatar = "http://www.dgtle.com/uc_server/avatar.php?uid=\(item.authorid ?? "")"

        titleLabel.text = item.content
        authorLabel.text = item.author
        likeLabel.text = item.likenum

        pictureView.sp.setImage(path: item.pic_url ?? "")
        avatarView.sp.setImageWithRounded(path: avatar,
                                          cornerRadius: 15,
                                          targetSize: CGSize(width: 30, height: 30))
    }

}
