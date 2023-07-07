//
//  MockNetwork.swift
//  News AppTests
//
//  Created by Yogesh on 7/6/23.
//

import Foundation
import UIKit
import XCTest
@testable import News_App

class MockNetwork: NetworkProtocol {
    
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        guard let url = urlReq.url,
              let _ = urlReq.url?.absoluteString.contains("https://newsapi.org/v2/top-headlines?country=us&apiKey=6c6dc38b321b4d298cf37b19c296f9aa")
        else{
            completion(nil, nil, nil)
            return
        }
        
        let bundle = Bundle(for: MockNetwork.self)
        
        if let path = bundle.path(forResource: "NewsResult", ofType: "json") {
            do{
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)
                
                completion(data, response, nil)
                
            } catch {
                completion(nil, nil, nil)
            }
        } else{
            completion(nil, nil, nil)
        }
        
    }
    
}
