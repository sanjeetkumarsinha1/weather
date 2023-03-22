//
//  ViewController.swift
//  Weather Forecast
//
//  Created by sanjeet on 21/03/23.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation?
    
    var cities: [String] = ["Ranchi", "Delhi", "Kolkata", "Bengaluru", "Noida"]
    var weatherData: [WeatherData] = []
    
    let apiKey = "7267020169c0050bd4c672774ad1f355"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherTableView.dataSource = self
        searchBar.delegate = self
        fetchWeatherData(for: cities)
        weatherTableView.register(WeatherTableViewCell.self, forCellReuseIdentifier: "weathercell")
    }
    
    func fetchWeatherData(for cities: [String]) {
        for city in cities {
            let url = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=\(apiKey)&units=metric"
            if let url = URL(string: url) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else {
                        print("Error: \(error!)")
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let weatherData = try decoder.decode(WeatherData.self, from: data)
                        self.weatherData.append(weatherData)
                        DispatchQueue.main.async {
                            self.weatherTableView.reloadData()
                        }
                    } catch {
                        print("Error decoding data: \(error)")
                    }
                }.resume()
            }else {
                // Handle the case where the URL is invalid
            }
            
        }
    }
    
    func fetchWeatherData(for location: CLLocation) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric"
        URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("Error: \(error!)")
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                self.weatherData.removeAll()
                self.weatherData.append(weatherData)
                DispatchQueue.main.async {
                    self.weatherTableView.reloadData()
                }
            } catch {
                print("Error decoding data: \(error)")
            }
        }.resume()
    }
    
    /*func getCityCoordinates() -> [CLLocationCoordinate2D] {
        return [
            CLLocationCoordinate2D(latitude: 23.3441, longitude: 85.3096),
            CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025),
            CLLocationCoordinate2D(latitude: 22.5726, longitude: 88.3639),
            CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
            CLLocationCoordinate2D(latitude: 28.5355, longitude: 77.3910)
        ]
    }*/
    
    @IBAction func getCurrentLocationWeather(_ sender: Any) {
        getCurrentLocation()
        guard let currentLocation = currentLocation else {
            print("Current location not available")
            return
        }
        //let city = getCityName(for: currentLocation)
        
        getCityName(for: currentLocation) { cityName in
            guard let cityName = cityName else {
                print("Could not fetch city name for current location")
                return
            }
            print("Current city: \(cityName)")
            self.searchBar.text = cityName
            self.fetchWeatherData(for: [cityName])
        }
    }
    
    func getCityName(for location: CLLocation, completion: @escaping (String?) -> Void) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            guard error == nil else {
                print("Error reverse geocoding location: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            if let placemark = placemarks?.first {
                let city = placemark.locality ?? ""
                completion(city)
            } else {
                completion(nil)
            }
        }
    }

    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.startUpdatingLocation()
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherData.count
        
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "weathercell", for: indexPath) as! WeatherTableViewCell
        
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell",for : indexPath) as! WeatherTableViewCell
        
        let data = weatherData[indexPath.row]
        
        print(data.list)
        
        cell.cityLabel.text = data.city.name
        cell.dateLabel.text = data.list[indexPath.row].dtTxt
        cell.weatherLabel.text = data.list.first?.weather.first?.description
        cell.temperatureLabel.text = "\(Int(data.list.first?.main.temp ?? 0))°C"
        return cell
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation = location
        print("Current location: (location.coordinate.latitude), (location.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }

}

extension WeatherViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //dropdownTblview.isHidden = false
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        cities.append(searchText)
        fetchWeatherData(for: cities)
    }
}


