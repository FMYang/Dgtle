//
//  DGMineUserInfoCell.swift
//  Dgtle
//
//  Created by yfm on 2019/7/22.
//  Copyright © 2019 yfm. All rights reserved.
//

import UIKit

class DGMineUserInfoCell: UITableViewCell {
    @IBOutlet weak var avatarView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        avatarView.layer.cornerRadius = 25
        avatarView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}
