//
//  Networking.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import Alamofire
import Foundation

class Networking {
    
    static let shared = Networking()
    
    func fetchData(completion: @escaping ([Car])->()) {
        let request = AF.request(UrlKeeper.carListUrl, method: .get)
        
        request.responseDecodable(of: [Car].self) { (data) in
            switch data.result {
            case .success(let decodedResponse):
                completion(decodedResponse)
            case .failure(let error):
                print("Data fetch error: \(error)")
                completion([])
            }
        }
    }
    
    func fetchImage(url: String?, completion: @escaping (Data?)->()) {
        let request = AF.request(url ?? "")
            
        request.response { (data) in
            switch data.result {
            case .success(let imageData):
                completion(imageData)
            case .failure(let error):
                print("Image fetch error: \(error)")
                completion(nil)
            }
        }
    }
}
