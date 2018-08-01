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
    
    
    
    func test_resultChanged() {
        
        let resultExpectation = expectation(description: "resultExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.searchResultChanged = {
            resultExpectation.fulfill()
        }
        
        viewModel.query = "success"
        
        wait(for: [resultExpectation], timeout: 2)
        
    }
    
    func test_result() {
        
        let resultExpectation = expectation(description: "resultExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.searchResultChanged = {
            [weak viewModel] in
            if let _ = viewModel?.result {
                resultExpectation.fulfill()
            }
        }
        
        viewModel.query = "success"
        
        wait(for: [resultExpectation], timeout: 2)
        
    }
    
    func test_errorChanged() {
        
        let errorExpectation = expectation(description: "errorExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.errorChanged = {
            errorExpectation.fulfill()
        }
        
        viewModel.query = "error"
        
        wait(for: [errorExpectation], timeout: 2)
    }
    
    func test_error() {
        
        let errorExpectation = expectation(description: "errorExpctation")
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.errorChanged = {
            [weak viewModel] in
            if let _ = viewModel?.error {
                errorExpectation.fulfill()
            }
        }
        
        viewModel.query = "error"
        
        wait(for: [errorExpectation], timeout: 2)
    }
    
    func test_isLoadingChanged() {
        
        let isLoadingExpectation = expectation(description: "isLoadingExpctation")
        isLoadingExpectation.expectedFulfillmentCount = 2
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        var prevValue = viewModel.isLoading
        
        viewModel.isLoadingChanged = {
            [weak viewModel] in
            if let weakViewModel = viewModel {
                if prevValue != weakViewModel.isLoading {
                    isLoadingExpectation.fulfill()
                    prevValue = weakViewModel.isLoading
                }
            }
        }
        
        viewModel.query = "something"
        
        wait(for: [isLoadingExpectation], timeout: 2)
        
    }
    
    func test_historyChange() {
        
        let historyChangeExpextation = expectation(description: "isLoadingExpctation")
        historyChangeExpextation.expectedFulfillmentCount = 6
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.historyChanged = {
            historyChangeExpextation.fulfill()
        }
        
        for i in 0..<12 {
            if i.quotientAndRemainder(dividingBy: 2).remainder == 0 {
                viewModel.query = "success\(i)"
            } else {
                viewModel.query = "error\(i)"
            }
        }
        wait(for: [historyChangeExpextation], timeout: 2)
    }
    
    func test_history() {
        
        let historyChangeExpextation = expectation(description: "isLoadingExpctation")
        historyChangeExpextation.expectedFulfillmentCount = 7
        
        let expectedHistory = ["success2", "success10", "success8", "success6", "success4"]
        
        let viewModel = SearchViewModel(dataProvider: DummyDataProvider())
        
        viewModel.historyChanged = {
            historyChangeExpextation.fulfill()
        }
        
        for i in 0..<12 {
            if i.quotientAndRemainder(dividingBy: 2).remainder == 0 {
                viewModel.query = "success\(i)"
            } else {
                viewModel.query = "error\(i)"
            }
        }
        XCTAssertEqual(viewModel.history.count, 5)
        
        viewModel.query = "success2"
        
        XCTAssertTrue(viewModel.history.elementsEqual(expectedHistory))
        
        wait(for: [historyChangeExpextation], timeout: 2)
    }
}
