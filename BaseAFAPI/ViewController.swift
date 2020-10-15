//
//  ViewController.swift
//  BaseAFAPI
//
//  Created by ManhLD on 10/8/20.
//

import UIKit

class ViewController: UIViewController {
    
    var model : [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()
        login()
    }
    
    private func getNewsData() {
        SampleGetNewsAPI(paramss: ["pageIndex": 1, "pageSize": 10]).execute { (response) in
            switch response {
            case .success(let news):
                self.model = news.response?.news ?? []
                print(self.model)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    private func login() {
        SampleLoginAPI(paramss: ["email": "fullterdev@gmail.com", "password": "25251325"]).execute { (response) in
            print(response)
            switch response {
            case .success(let loginRes):
                print(loginRes)
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
}

