//
//  SearchViewModelTests.swift
//  themoviedb-appTests
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import XCTest
@testable import themoviedb_app
class SearchViewModelTests: XCTestCase {
    
    func test_resultRecievedNotification() {
        
        let resultExpctation = expectation(description: "resultExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.resultReceived = {
            resultExpctation.fulfill()
        }
        
        viewModel.query = "success"
        
        wait(for: [resultExpctation], timeout: 2)
        
    }
    
    func test_errorRecievedNotification() {
        
        let resultExpctation = expectation(description: "resultExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.errorReceived = {
            resultExpctation.fulfill()
        }
        
        viewModel.query = "error"
        
        wait(for: [resultExpctation], timeout: 2)
        
    }
}
