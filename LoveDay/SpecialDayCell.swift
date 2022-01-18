//
//  SpecialDayCell.swift
//  LoveDay
//
//  Created by 이찬호 on 2022/01/18.
//

import UIKit

class SpecialDayCell: UITableViewCell {

    @IBOutlet weak var spImage: UIImageView!
    @IBOutlet weak var spDay: UILabel!
    @IBOutlet weak var subscribe: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        spImage.layer.masksToBounds = true
        spImage.layer.cornerRadius = spImage.frame.width / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
