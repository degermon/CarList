//
//  Networking.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import Alamofire

class Networking {
    
    static let shared = Networking()
    
    func fetchData(completion: @escaping ([Car])->()) {
        let request = AF.request(UrlKeeper.carListUrl, method: .get)
        
        request.responseDecodable(of: [Car].self) { (data) in
            switch data.result {
            case .success(let decodedResponse):
                print(decodedResponse)
                completion(decodedResponse)
            case .failure(let error):
                print("Data fetch error: \(error)")
                completion([])
            }
        }
    }
}
