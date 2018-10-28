//
//  CountryTableViewCell.swift
//  CountriesExplorer
//
//  Created by  William on 10/14/18.
//  Copyright © 2018 Vasiliy Lada. All rights reserved.
//

import UIKit
import Alamofire
import WebKit

class CountryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var flagImage: UIImageView!
    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var currencies: UILabel!
    
    var item: Country? {
        didSet {
            guard let item = item else {
                return
            }
            
            countryName.text = item.name
            capital.text = item.capital
            currencies.text = item.currencies?.joined(separator: ",")
            // TODO: set flag image
            flagImage.image = UIImage(named: "flag")
        }
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.accessoryType = .disclosureIndicator
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        flagImage.image = nil
    }
    
}
