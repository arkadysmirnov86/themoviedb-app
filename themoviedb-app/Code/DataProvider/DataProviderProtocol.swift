//
//  DataProviderProtocol.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/1/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

protocol DataProviderProtocol {
    typealias ResultType = PageEntity<FilmInfoEnity>
    
    func fetchFilms(query: String, page: Int, completionhandler: @escaping (Result<ResultType>) -> Void)
}
