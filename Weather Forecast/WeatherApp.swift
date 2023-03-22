//
//  WeatherApp.swift
//  Weather Forecast
//
//  Created by chetu on 20/03/23.
//

import UIKit
import CoreLocation

class WeatherApp: NSObject {
    private var cities: [String] = []
    private var currentLocation: CLLocation?
    private var weatherData: [WeatherData] = []
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func addCity(_ city: String) {
        cities.append(city)
    }
    
    func removeCity(at index: Int) {
        cities.remove(at: index)
    }
    
    func updateWeatherData() {
        for city in cities {
            getWeatherData(for: city)
        }
    }
    
    func getWeatherForecast(forCity city: String, apiKey: String, completion: @escaping ([WeatherForecast]) -> Void) {

        let url = URL(string: "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric")!

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                // Handle error
                print(error.localizedDescription)
                return
            }

            guard let data = data else {
                // Handle missing data
                print("No data returned from API")
                return
            }

            do {
                let decoder = JSONDecoder()
                let forecastResponse = try decoder.decode(ForecastResponse.self, from: data)
                completion(forecastResponse.list)
            } catch {
                // Handle parsing errors
                print(error.localizedDescription)
            }
        }

        task.resume()
    }

    
    func getWeatherData(for city: String) {
        let apiKey = "7267020169c0050bd4c672774ad1f355"
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            guard let self = self else { return }
            
            self.weatherData.append(contentsOf: self.parseWeatherData(data))
        }.resume()
    }
    
    private func parseWeatherData(_ data: Data) -> [WeatherData] {
        // Parse the JSON data and extract the relevant information
        // Return an array of WeatherData objects
        return []
    }
}

extension WeatherApp: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager error: \(error.localizedDescription)")
    }
}

struct WeatherForecast: Codable {
    let date: Date
    let temperature: Double
    let humidity: Int
    let windSpeed: Double
    let weatherCondition: String

    enum CodingKeys: String, CodingKey {
        case date = "dt_txt"
        case temperature = "main.temp"
        case humidity = "main.humidity"
        case windSpeed = "wind.speed"
        case weatherCondition = "weather.0.main"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let dateString = try container.decode(String.self, forKey: .date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            self.date = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: .date, in: container, debugDescription: "Invalid date format")
        }

        self.temperature = try container.decode(Double.self, forKey: .temperature)
        self.humidity = try container.decode(Int.self, forKey: .humidity)
        self.windSpeed = try container.decode(Double.self, forKey: .windSpeed)
        self.weatherCondition = try container.decode(String.self, forKey: .weatherCondition)
    }
}

struct ForecastResponse: Codable {
    let list: [WeatherForecast]
}
