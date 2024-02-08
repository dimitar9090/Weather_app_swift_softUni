//
//  NetworkManager.swift
//  SoftUniWeatherApp
//
//  Created by Ivan Chavdarov Ivanov on 23.01.24.
//

import Foundation

class NetworkManager {
    var location: String
    let url: String
    
    init(location: String) {
        self.location = location
        url = "https://api.weatherapi.com/v1/current.json?q=\(location)&key=c5d4889e133646b08dc180749242101"
    }
    
    func getData(completion: @escaping (Weather) -> Void) {
        print("Calling endpoint...")
        
        let url = URL(string: url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let jsonData = try decoder.decode(Weather.self, from: data)
                        completion(jsonData)
                        print("Ready")
                    } catch {
                        print("Error in parsing json file")
                    }
                } else {
                    print("No data received!")
                }
            } else {
                print("HTTP Response Error: \(httpResponse.statusCode)")
            }
        }
        
        task.resume()
    }
    
}
