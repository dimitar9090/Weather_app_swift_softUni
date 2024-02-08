//
//  ViewController.swift
//  SoftUniWeatherApp
//
//  Created by Ivan Chavdarov Ivanov on 23.01.24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.becomeFirstResponder()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textField.resignFirstResponder()
    }
    
    @IBAction func goBtnTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let weatherVC = storyboard.instantiateViewController(withIdentifier: "WeatherVC") as! WeatherViewController
        
        guard let text = textField.text, text != "" else { return }
        
        weatherVC.networkMenager = NetworkManager(location: text)
        
        navigationController?.pushViewController(weatherVC, animated: true)
    }
    


}

