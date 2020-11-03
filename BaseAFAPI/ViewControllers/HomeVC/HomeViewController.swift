//
//  HomeViewController.swift
//  BaseAFAPI
//
//  Created by ManhLD on 11/3/20.
//

import UIKit

class HomeViewController: BaseViewController {
    
    var model : [NewsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()
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
    
}
