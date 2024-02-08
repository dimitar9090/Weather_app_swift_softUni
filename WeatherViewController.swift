//
//  WeatherViewController.swift
//  SoftUniWeatherApp
//
//  Created by Ivan Chavdarov Ivanov on 23.01.24.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var weather: Weather?
    var networkMenager: NetworkManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current weather"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        networkMenager.getData { weather in
            self.weather = weather
            DispatchQueue.main.async {
                self.label.text = weather.location.name
                let imageString = "https:" + weather.current.condition.icon
                
                if let imageURL = URL(string: imageString) {
                    print(imageURL)
                    self.loadImage(from: imageURL, into: self.imageView)
                }
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error loading image: \(error)")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    imageView.image = image
                }
            }
        }
        
        task.resume()
    }
    
}

extension WeatherViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let weather = weather else { return cell }
        
        var contentConfig = UIListContentConfiguration.cell()
        
        switch indexPath.row {
        case 0:
            contentConfig.text = "Last Updated:"
            contentConfig.secondaryText = weather.current.lastUpdated
        case 1:
            contentConfig.text = "Current temp.:"
            contentConfig.secondaryText = String(weather.current.tempC)
        case 2:
            contentConfig.text = "Feels like:"
            contentConfig.secondaryText = String(weather.current.feelslikeC)
        case 3:
            contentConfig.text = "Humidity:"
            contentConfig.secondaryText = String(weather.current.humidity)
        case 4:
            contentConfig.text = "UV Index:"
            contentConfig.secondaryText = String(weather.current.uv)
        default:
            break
        }
        
        cell.contentConfiguration = contentConfig
        
        return cell
    }
    
}
