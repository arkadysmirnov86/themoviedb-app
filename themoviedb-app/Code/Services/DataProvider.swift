//
//  DataProvider.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    func fetchFilms(successHandler: ([FilmInfoEnity]) -> Void, errorHandler: (Error) -> Void)
}

class DataProvider: DataProviderProtocol {
    func fetchFilms(successHandler: ([FilmInfoEnity]) -> Void, errorHandler: (Error) -> Void) {
        fatalError("method not implemeted")
    }
}
