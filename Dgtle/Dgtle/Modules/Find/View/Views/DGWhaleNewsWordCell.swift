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
        maskImageView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(item: DGWhaleNewsItem) {
        contentLabel.text = item.message
        coverImageView.sp.setImageWithCrop(path: item.cover_name ?? "")
    }
    
}
