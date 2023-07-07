//
//  NetworkLayer.swift
//  News App
//
//  Created by Yogesh on 7/4/23.
//

import Foundation
import UIKit

protocol NetworkProtocol {
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void)
}

class Network: NetworkProtocol {
    func getData(urlReq: URLRequest, completion: @escaping (Data?, HTTPURLResponse?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: urlReq, completionHandler:{ data, response, error in
            completion(data, response as? HTTPURLResponse, error)
        })
        task.resume()
    }
}


class NetworkClient{
    var network: NetworkProtocol
    
    init(network: NetworkProtocol = Network()){
        self.network = network
    }
    
    func callApi(completionHandler: @escaping (AllData?) -> () ){
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=6c6dc38b321b4d298cf37b19c296f9aa")
        
        let req = URLRequest(url: url!)
        
        network.getData(urlReq: req, completion: { data, response, error in
            
            
            //let task = URLSession.shared.dataTask(with: req, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("Error:", error)
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Response error: ", error)
                completionHandler(nil)
                return
            }
            
            if let data = data {
                let op = String(data: data, encoding: .utf8)
                print(op)
            }
            
            if let data = data {
                do { let decoder = JSONDecoder()
                    let ans = try decoder.decode(AllData.self, from: data)
                    completionHandler(ans)
                }catch {
                    print("Decoding Error: ", error)
                }
            }
        })
    }
    
    
    func fetchImage(link: String, completionHandler: @escaping (UIImage?) -> ()){
        guard let url = URL(string: link) else {
            return
        }
        
        let req = URLRequest(url: url)
        
        
        network.getData(urlReq: req, completion: { data, response, error in
            
            //let task = URLSession.shared.dataTask(with: req, completionHandler: { data, response, error in
            
            guard error == nil else {
                print("Error:", error)
                completionHandler(nil)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("Response error: ", error)
                completionHandler(nil)
                return
            }
            
            if let data = data {
                let img = UIImage(data: data)
                completionHandler(img)
            }
        })
        
    }
    
    
    
}


