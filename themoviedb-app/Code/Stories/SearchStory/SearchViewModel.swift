//
//  SearchViewModel.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    private var dataProvider: DataProviderProtocol
    //TODO: have to be stored in userdefaults
    private var lastSuccessfulQueries: [String]
    
    
    var errorChanged: VoidClosure?
    var isLoadingChanged: VoidClosure?
    var historyChanged: VoidClosure?
    
    var query: String? {
        didSet {
            guard let query = query else {
                return
            }
            isLoading = true
            dataProvider.fetchMovies(query: query, page: 1) { (result) in
                switch result {
                case .success(let value):
                    self.updateQueriesHistory(newQuery: query)
                    self.coordinatorDelegate?.showSearchResult(firstPage: value.asModel)
                case .error(let error):
                    self.error = error
                }
                self.isLoading = false
            }
        }
    }
    
    private (set) var error: Error? {
        didSet {
            errorChanged?()
        }
    }
    
    private (set) var isLoading: Bool = false {
        didSet {
            isLoadingChanged?()
        }
    }
    
    var history: [String] {
        return lastSuccessfulQueries
    }
    
    var coordinatorDelegate: SearchCoordinatorDelegate?
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        lastSuccessfulQueries = ["test", "test2", "test3"]
    }
    
    private func updateQueriesHistory(newQuery: String) {
        if let existingIndex = lastSuccessfulQueries.index(of: newQuery){
            lastSuccessfulQueries.remove(at: existingIndex)
            lastSuccessfulQueries.insert(newQuery, at: 0)
        } else {
            lastSuccessfulQueries.insert(newQuery, at: 0)
            if lastSuccessfulQueries.count > 5 {
                lastSuccessfulQueries.removeLast()
            }
        }
        self.historyChanged?()
    }
}
