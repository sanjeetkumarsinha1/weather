//
//  WeatherTableViewCell.swift
//  Weather Forecast
//
//  Created by chetu on 21/03/23.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!

    func configure(with forecast: ForecastData) {
        // Configure the cell with forecast data
        dateLabel.text = forecast.dtTxt
        temperatureLabel.text = "\(forecast.main.temp)°C"
        weatherLabel.text = forecast.weather[0].main
        cityLabel.text = forecast.weather.description
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
