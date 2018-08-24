//
//  ViewController.swift
//  LocationFinder
//
//  Created by Todd B Sanders on 8/24/18.
//  Copyright © 2018 Todd B Sanders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var PostalCodeLabel: UILabel!
    
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let ipInfoURL = URL(string: "http://ipinfo.io/json")!
        let urlSession = URLSession.shared
        
        let task = urlSession.dataTask(with: ipInfoURL) { (data, response, error) in
            
            guard let data = data, error == nil else { return }
            
            do {
                let userLocation = try JSONDecoder().decode(UserLocation.self, from: data)
                
                DispatchQueue.main.async {
                    
                    //Update UI
                    self.countryLabel.text = userLocation.country
                    self.cityLabel.text = userLocation.city
                    self.PostalCodeLabel.text = userLocation.postal
                    self.flagImageView.image = UIImage(named: userLocation.country.lowercased())
                }
                
                
            } catch let error as NSError {
                print(error)
            }
            
        }
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

