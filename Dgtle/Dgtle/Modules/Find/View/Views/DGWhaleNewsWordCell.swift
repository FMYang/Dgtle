//
//  DGWhaleNewsWordCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/21.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGWhaleNewsWordCell: UITableViewCell, DGWhaleNewsProtocol {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        maskImageView.round(10, size: CGSize(width: screen_width-40, height: 150))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(item: DGWhaleNewsItem) {
        contentLabel.text = item.message
        coverImageView.sp.setImageWithCrop(path: item.cover_name ?? "",
                                           radius: 10)
    }
    
}
