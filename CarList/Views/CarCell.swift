//
//  CarCell.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit

class CarCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var plateNumber: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var batteryEstimatedDistnce: UILabel!
    @IBOutlet weak var distanceToCar
        : UILabel!
    @IBOutlet weak var carImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
