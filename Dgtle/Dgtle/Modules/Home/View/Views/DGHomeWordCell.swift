//
//  DGHomeWordCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/24.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGHomeWordCell: UITableViewCell {
    @IBOutlet weak var maskImageView: UIImageView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        maskImageView.round(10, size: CGSize(width: screen_width-40, height: 150))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension DGHomeWordCell: DGHomeCellProtocol {
    func configCell(model: DGHomeListItem) {
        titleLabel.text = model.title
        pictureView.sp.setImageWithCrop(path: model.cover_name ?? "",
                                           radius: 10)
    }
}
