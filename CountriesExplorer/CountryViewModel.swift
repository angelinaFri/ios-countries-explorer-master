//
//  CountryViewModel.swift
//  CountriesExplorer
//
//  Created by  William on 10/15/18.
//  Copyright © 2018 Vasiliy Lada. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class CountryViewModel: NSObject {
    
    var tableView: UITableView? {
        didSet {
            tableView?.reloadData()
        }
    }
    
    private(set) var items = [Country]()
    
    override init() {
        super.init()
        fetchData()
    }
    
    private func fetchData() {
        Alamofire.request("https://restcountries.eu/rest/v2/all").responseJSON { response in
            response.result.ifSuccess {
                let responseJSON: JSON = JSON(response.result.value!)
                responseJSON.array?.forEach({ json in
                    self.items.append(Country(json))
                })
                
                self.tableView?.reloadData()
            }
        }
    }
    
    func setAsDataSource(for table: UITableView) {
        self.tableView = table
        table.dataSource = self
    }
}

extension CountryViewModel: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.identifier, for: indexPath) as? CountryTableViewCell {
            cell.countryName.text = items[indexPath.row].name
            cell.capital.text = items[indexPath.row].capital
            cell.currencies.text = items[indexPath.row].currencies?.joined()
            if let imageURL = URL(string: items[indexPath.row].flagUrl!) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imageURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            cell.flagImage.image = image
                        }
                    }
                }
            }

            return cell
        }
        
        return UITableViewCell()
    }
    
}
