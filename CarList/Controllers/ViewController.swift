//
//  ViewController.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        setupCarListObserver()
        setupCellConfiguration()
        fetchCars()
    }

    private func fetchCars() {
        Networking.shared.fetchCarData { (result) in
            CarList.shared.list.accept(result)
        }
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "CarCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "carCell")
    }

}
