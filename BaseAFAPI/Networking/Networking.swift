//
//  Networking.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import Foundation
import Alamofire


typealias APIClient = APIOperation & Request


protocol APIOperation {
    associatedtype Model: Decodable
    func execute(completion: @escaping (Result<Model, Error>) -> Void)
}


extension APIOperation where Self: Request {
    func execute(completion: @escaping (Result<Model, Error>) -> Void) {
        self.printInfomationRequest()
        AF.request(self.request).responseDecodable(of: Model.self) { (response) in
            DispatchQueue.main.async {
                if let error = response.error {
                    switch error {
                    case .sessionTaskFailed(let urlError as URLError):
                        completion(.failure(urlError))
                    default:
                        completion(.failure(error))
                    }
                } else {
                    guard let data = response.data else {
                        completion(.failure(NetworkError.noData))
                        return
                    }
                    do {
                        let dataModel = try JSONDecoder().decode(Model.self, from: data)
                        completion(Result<Model, Error>.success(dataModel))
                    } catch let error {
                        completion(Result<Model, Error>.failure(error))
                    }
                }
            }
        }
    }
}
