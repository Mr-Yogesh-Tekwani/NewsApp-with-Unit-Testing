//
//  NewsAppUITests.swift
//  News AppTests
//
//  Created by Yogesh on 7/6/23.
//

import Foundation

import XCTest

@testable import News_App

class ViewControllerUITests: XCTestCase {

    func testInit() throws {
        let vc = ViewController()
        XCTAssertEqual(vc.view.subviews.count, 1)
        
        let stack = try XCTUnwrap(vc.view.subviews.first as? UIStackView)
        XCTAssertEqual(stack.arrangedSubviews.count, 1)
        _ = try XCTUnwrap(stack.arrangedSubviews.first as? UITableView)
    }
    
    func testStackView() throws {
        let vc = ViewController()
        
        XCTAssertEqual(vc.mainStack.distribution, .fill)
        XCTAssertEqual(vc.mainStack.alignment, .fill)
        XCTAssertEqual(vc.mainStack.axis, .horizontal)
        XCTAssertEqual(vc.mainStack.spacing, 10)
        
    }

}

