//
//  dailyWeatherCell.swift
//  Weather
//
//  Created by Amardeep Kaur on 18/02/21.
//

import UIKit

class DailyWeatherCell: UITableViewCell {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
//        stackView.setCustomSpacing(10, after: dayLabel)
//        stackView.setCustomSpacing(20, after: weatherIcon)
    }

}
