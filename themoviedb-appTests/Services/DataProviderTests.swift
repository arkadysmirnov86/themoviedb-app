//
//  DataProviderTests.swift
//  themoviedb-appTests
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import XCTest
@testable import themoviedb_app
class DataProviderTests: XCTestCase {
    
    func test_fetchFilms() {
        let expectaionOfResult = expectation(description: "data isn't empty")
        let dataProvider = DataProvider()
        dataProvider.fetchFilms(query: "batman", page: 1) { (result) in
            switch result {
            case .success(let value):
                expectaionOfResult.fulfill()
            case .error(let error):
                XCTFail("\(error)")
            }

        }
        wait(for: [expectaionOfResult], timeout: 10)
    }
    
    
}
