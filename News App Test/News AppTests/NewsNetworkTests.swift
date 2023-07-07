//
//  NewsNetworkTests.swift
//  News AppTests
//
//  Created by Yogesh on 7/6/23.
//

import Foundation
import XCTest
@testable import News_App

class NewsNetworkTests: XCTestCase {
    
    func testApiCall() throws{
        let networkClient = NetworkClient(network: MockNetwork())
        
        let cellCompletedSignal = expectation(description: "testCallApi")
        
        var result : AllData? = nil
        
        networkClient.callApi(completionHandler: { resultData in
            result = resultData
            cellCompletedSignal.fulfill()
        })
        
        
        waitForExpectations(timeout: 3)
        XCTAssertNotNil(result)
        
        let resArray = try XCTUnwrap(result?.allArticles)
        print(resArray)
        XCTAssertEqual(resArray[0].title, "Earth's hottest day ever was recorded on July 3, 2023 - NBC 5 Dallas-Fort Worth")
        
        
    }
    
}
