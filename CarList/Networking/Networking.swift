//
//  Networking.swift
//  CarList
//
//  Created by Daniel Šuškevič on 2020-10-07.
//

import Alamofire
import AlamofireImage
import Foundation

class Networking {
    static let shared = Networking()

    func fetchCarData(completion: @escaping ([Car])->()) {
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
    
    func getImageFor(url: String?, completion: @escaping (Image?)->()) {
        let request = AF.request(url ?? "", method: .get)
        request.responseImage { (response) in
            switch response.result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print("Image fetch error: \(error)")
                completion(nil)
            }
        }
        completion(nil) // no image received
    }
}
