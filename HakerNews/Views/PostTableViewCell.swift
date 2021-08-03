//
//  PostTableViewCell.swift
//  HakerNews
//
//  Created by Admin on 2021/8/3.
//

import UIKit

class PostTableViewCell: UITableViewCell {

    @IBOutlet weak var lblNumber: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSubTitle: UILabel!
    @IBOutlet weak var btnMain: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
