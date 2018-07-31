//
//  DataProvider.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    typealias ResultType = PageEntity<FilmInfoEnity>
    func fetchFilms(complitionhandler: (Result<ResultType>) -> Void)
}

class DataProvider: DataProviderProtocol {
    func fetchFilms(complitionhandler: (Result<ResultType>) -> Void) {
        fatalError("method not implemeted")
    }
}
