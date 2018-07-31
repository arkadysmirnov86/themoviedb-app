//
//  DummyDataProvider.swift
//  themoviedb-appTests
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation
@testable import themoviedb_app

class DummyDataProvider: DataProviderProtocol {
    
    enum Errors: Error {
        case fakeError
    }
    
    func fetchFilms(query: String, page: Int, completionhandler: @escaping (Result<DataProviderProtocol.ResultType>) -> Void) {
        switch query {
        case "success":
            let result = DataProviderProtocol.ResultType(page: 1, total_results: 1, total_pages: 1, results: [FilmInfoEnity(id: 1, title: "title")])
            completionhandler(Result<DataProviderProtocol.ResultType>.success(result))
        case "error":
            completionhandler(Result<DataProviderProtocol.ResultType>.error(Errors.fakeError))
        default:
            break
        }
    }
}
