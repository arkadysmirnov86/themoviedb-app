//
//  DataProvider.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class DataProvider: DataProviderProtocol {
    typealias ResultType = PageEntity<MovieEnity>
    
    enum Errors: Error {
        case unknownError
        case invalidParams
        case dataIsEmpty
    }
    func fetchMovies(query: String, page: Int, completionhandler: @escaping (Result<ResultType>) -> Void) {
        let session = URLSession.shared
        
        guard let url = URL(string: String(format: .endpointFormat, query, page)) else {
            completionhandler(Result<ResultType>.error(Errors.invalidParams))
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            //TODO: redirect current thread task to main queue
            
            guard error == nil else {
                let error = error ?? Errors.unknownError
                DispatchQueue.main.async {
                    completionhandler(Result<ResultType>.error(error))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completionhandler(Result<ResultType>.error(Errors.dataIsEmpty))
                }
                return
            }
            
            do {
                let value = try JSONDecoder.init().decode(ResultType.self, from: data)
                DispatchQueue.main.async {
                    completionhandler(Result<ResultType>.success(value))
                }
            } catch {
                DispatchQueue.main.async {
                    completionhandler(Result<ResultType>.error(error))
                }
            }
        }
        
        task.resume()
    }
}

private extension String {
    
    static let endpointFormat = "http://api.themoviedb.org/3/search/movie?api_key=2696829a81b1b5827d515ff121700838&query=%@&page=%d"
}
