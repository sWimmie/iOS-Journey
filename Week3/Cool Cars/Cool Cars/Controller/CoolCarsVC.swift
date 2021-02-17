//
//  CoolCarsVC.swift
//  Cool Cars
//
//  Created by Wim van Deursen on 10/02/2021.
//

import UIKit

class CoolCarsVC: UIViewController {
    
    var selectedCar: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onTeslaTapped(_ sender: Any) {
        selectedCar = "TESLA"
        performSegue(withIdentifier: "carSpecsVCSegue", sender: self)
    }
    
    @IBAction func onPolestarTapped(_ sender: Any) {
        selectedCar = "POLESTAR"
        performSegue(withIdentifier: "carSpecsVCSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let carSpecsVC = segue.destination as? CarSpecsVC {
            guard let dataPath = Bundle.main.path(forResource: "car-info", ofType: "json") else {return}
            let url = URL(fileURLWithPath: dataPath)
            
            do {
                let data = try Data(contentsOf: url)
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                guard let carArray = json as? [Any] else {return}
                for car in carArray {
                    guard let carDict = car as? [String: Any] else {return}
                    guard let brand = carDict["brand"] as? String else {return}
                    guard let model = carDict["model"] as? String else {return}
                    guard let year = carDict["year"] as? Int else {return}
                    guard let topspeed = carDict["topspeed"] as? Int else {return}
                    guard let mileage = carDict["mileage"] as? Int else {return}
                    guard let accelaration = carDict["accelaration"] as? String else {return}
                    guard let horsepower = carDict["horsepower"] as? Int else {return}
                    guard let picture = carDict["picture"] as? String else {return}
                    
                    if selectedCar.contains(brand) {
                        carSpecsVC.brand = brand
                        carSpecsVC.model = model
                        carSpecsVC.year = String(year)
                        carSpecsVC.mileage = String(mileage)
                        carSpecsVC.accelaration = accelaration
                        carSpecsVC.topspeed = String(topspeed)
                        carSpecsVC.horsepower = String(horsepower)
                        carSpecsVC.picture = picture
                    }
                }      
            } catch {
                print(error)
            }
        }
    }

}
