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
    
    func fetchFilms(query: String, page: Int, completionhandler: @escaping (Result<ResultType>) -> Void)
}

class DataProvider: DataProviderProtocol {
    typealias ResultType = PageEntity<FilmInfoEnity>
    
    enum Errors: Error {
        case unknownError
        case invalidParams
        case dataIsEmpty
    }
    func fetchFilms(query: String, page: Int, completionhandler: @escaping (Result<ResultType>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: String(format: .endpointFormat, query, page)) else {
            completionhandler(Result<ResultType>.error(Errors.invalidParams))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error != nil else {
                let error = error ?? Errors.unknownError
                completionhandler(Result<ResultType>.error(error))
                return
            }
            
            guard let data = data else {
                completionhandler(Result<ResultType>.error(Errors.dataIsEmpty))
                return
            }
            
            do {
                let value = try JSONDecoder.init().decode(ResultType.self, from: data)
                completionhandler(Result<ResultType>.success(value))
            } catch {
                completionhandler(Result<ResultType>.error(error))
            }
        }
        
        task.resume()
    }
}

private extension String {
    static let endpointFormat = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=%@&page=%d"
}
