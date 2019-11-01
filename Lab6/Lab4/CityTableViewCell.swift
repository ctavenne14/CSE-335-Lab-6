//
//  CityTableViewCell.swift
//  Lab4
//
//  Created by Cody Tavenner on 2/18/19.
//  Copyright © 2019 Cody Tavenner. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var cityimage: UIImageView!{
        didSet {
            cityimage.layer.cornerRadius = cityimage.bounds.width / 2
            cityimage.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
