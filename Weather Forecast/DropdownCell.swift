//
//  DropdownCell.swift
//  Weather Forecast
//
//  Created by chetu on 21/03/23.
//

import UIKit

class DropdownCell: UITableViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
