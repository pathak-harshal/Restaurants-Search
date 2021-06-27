//
//  RestaurantTVC.swift
//  Restaurants Search
//
//  Created by Harshal Pathak on 26/06/21.
//

import UIKit
import AlamofireImage

class RestaurantTVC: UITableViewCell {

    
    //MARK: - Outlets for showing data in tablview cell
    @IBOutlet weak var imgRestaurantImage: UIImageView!
    @IBOutlet weak var lblRestaurantName: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var viewRating: UIView!
    @IBOutlet weak var lblRating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //MARK: - Making view circular by giving corner radius to half of its width and height provided that view is square
        viewRating.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Showing data for per model
    func setData(withObject model: Businesses) {
        lblRestaurantName.text = model.name
        lblRating.text = "\(model.rating ?? 0.0)"
        guard let status = model.is_closed else { return }
        if status {
            lblStatus.text = "Currently OPEN"
        } else {
            lblStatus.text = "Currently CLOSE"
        }
        
        lblAddress.text = getdistanceWithAddress(distance: model.distance, location: model.location)
            
        if let str = model.image_url {
            if let url = URL(string: str) {
                imgRestaurantImage.af.setImage(withURL: url)
            } else {
                imgRestaurantImage.image = UIImage(named: "restaurants_placeholder")
            }
        } else {
            imgRestaurantImage.image = UIImage(named: "restaurants_placeholder")
        }
    }

    //MARK: - Getting distance and address or restaurants
    func getdistanceWithAddress(distance: Double?, location: Location?) -> String {
        var address = ""
        var distanceWithAddress = ""
        if let displayAddress = location?.display_address {
         for addressLine in displayAddress {
             address = address + "\(addressLine) "
         }
        }
        
        if let dis = distance {
            let distanceValue = Int(dis.rounded())
            let valueInDistance = Double(distanceValue) / Double(1000)
            if distanceValue < 1000 {
                distanceWithAddress = "\(distanceValue) M, \(address)"
            } else {
                distanceWithAddress = "\(valueInDistance.getDispalyValue()) KM, \(address.trimmingCharacters(in: .whitespaces))"
            }
        }
        
        return distanceWithAddress
    }
}

