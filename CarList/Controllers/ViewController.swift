//
//  ViewController.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit

class ViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    var carList: [Car] = []
//    {
//        didSet { tableView.reloadData() }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        fetchCars()
    }

    private func fetchCars() {
        Networking.shared.fetchData { (result) in
            self.carList = result
            self.tableView.reloadData()
        }
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
    }

}