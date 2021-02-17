//
//  CarSpecsVC.swift
//  Cool Cars
//
//  Created by Wim van Deursen on 10/02/2021.
//

import UIKit

class CarSpecsVC: UIViewController {

    var brand: String!
    var model: String!
    var year: String!
    var topspeed: String!
    var mileage: String!
    var accelaration: String!
    var horsepower: String!
    var picture: String!
    
    @IBOutlet weak var brandLbl: UILabel!
    @IBOutlet weak var modelLbl: UILabel!
    @IBOutlet weak var rangeLbl: UILabel!
    @IBOutlet weak var accelerateLbl: UILabel!
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var horsePowerLbl: UILabel!
    @IBOutlet weak var carImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        brandLbl.text = brand ?? ""
        modelLbl.text = "\(year ?? "") - \(model ?? "")"
        rangeLbl.text = mileage ?? ""
        accelerateLbl.text = accelaration ?? ""
        speedLbl.text = topspeed ?? ""
        horsePowerLbl.text = horsepower ?? ""
        carImage.image = UIImage(named: picture ?? "")
    }
    
}
