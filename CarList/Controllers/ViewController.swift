//
//  ViewController.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit

class ViewController: UIViewController {
        
    var carList: [Car] = [] {
        didSet { tableView.reloadData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureTablewView()
        fetchCars()
    }

    private func fetchCars() {
        Networking.shared.fetchData { (result) in
            self.carList = result
        }
    }

}
