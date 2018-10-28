//
//  CountryModel.swift
//  CountriesExplorer
//
//  Created by  William on 10/15/18.
//  Copyright © 2018 Vasiliy Lada. All rights reserved.
//

import Foundation
import SwiftyJSON

enum CountryViewModelType {
    case compact
    case full
}

class Country {
    let name: String?
    let capital: String?
    let currencies: [String]?
    let flagUrl: String?
    
    init(_ json: JSON) {
        name = json["name"].string
        capital = json["capital"].string
        flagUrl = json["flag"].string
        
        var currencyCodes = [String]()
        json["currencies"].array?.forEach({ currencyJsonObject in
            if let currencyCode = currencyJsonObject["code"].string {
                currencyCodes.append(currencyCode)
            }
        })
        currencies = currencyCodes
    }
}
