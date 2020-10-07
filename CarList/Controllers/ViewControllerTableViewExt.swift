//
//  ViewControllerTableViewExt.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import UIKit

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "carCell", for: indexPath) 

        cell.textLabel?.text = carList[indexPath.row].model?.title

        return cell
    }
}
