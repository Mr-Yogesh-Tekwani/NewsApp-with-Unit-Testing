//
//  ViewControllerViewModel.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import Foundation
import UIKit

class ViewControllerViewModel{
    
    var allData : AllData?
    weak var viewController: ViewController?
    let networkClient = NetworkClient()
    
    func makeVc() -> UIViewController{
        let vc = ViewController()
        vc.viewModel = self
        self.viewController = vc
        return vc
    }
    
    func getData() {
        networkClient.callApi(completionHandler: { data in
            self.allData = data
            self.viewController?.allData = data
        })
    }
    
    func getRowCount() -> Int {
        return allData?.allArticles.count ?? 0
    }
    
    
    func getCellData(rowNumber: Int) -> CustomTableViewCell.Model? {
        
        let cellData = allData?.allArticles[rowNumber]
        
        let model = CustomTableViewCell.Model(title: cellData?.title,
                                              desc: cellData?.description,
                                              source: cellData?.source?.name,
                                              imgUrl: cellData?.urlToImage)
        return model
        
    }
    
    
    
}
