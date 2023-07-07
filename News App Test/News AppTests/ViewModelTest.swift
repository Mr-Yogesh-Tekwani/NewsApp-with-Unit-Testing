//
//  ViewModelTest.swift
//  News AppTests
//
//  Created by Yogesh on 7/5/23.
//

import XCTest
@testable import News_App

class ViewModelTest: XCTestCase {


    func testInitialize(){
        let viewModel = ViewControllerViewModel()
        XCTAssertNil(viewModel.allData)
        XCTAssertNil(viewModel.viewController)
    }
    
    func testMakeVc() throws {
        let viewModel = ViewControllerViewModel()
        let vc = try XCTUnwrap(viewModel.makeVc() as? ViewController)
        XCTAssertNotNil(vc.viewModel)
        XCTAssertEqual(viewModel.viewController, vc)
        
    }
    
    
    func testRowCount() throws{
        let e1 : Article = .init(source: nil, title: "T1", description: "D1", url: "U1", urlToImage: "uTi1", publishedAt: "", content: "")
        
        let e2 : Article = .init(source: nil, title: "T2", description: "D2", url: "U2", urlToImage: "uTi2", publishedAt: "", content: "")
        
        let a1: AllData = .init(availableStatus: "A1", resultsCount: 2, allArticles: [e1, e2])
        
        let viewModel = ViewControllerViewModel()
        XCTAssertEqual(viewModel.getRowCount(), 0)
        
        viewModel.allData = a1
        XCTAssertEqual(viewModel.getRowCount(), 2)
        let model = try XCTUnwrap(viewModel.getCellData(rowNumber:0))
        print(model)
        XCTAssertEqual(model.title, "T1")
        XCTAssertEqual(model.desc, "D1")
        XCTAssertEqual(model.imgUrl, "uTi1")
        XCTAssertEqual(model.source, nil)
        
    }
    

}
