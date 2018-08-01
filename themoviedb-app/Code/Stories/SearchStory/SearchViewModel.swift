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
    var searchResultChanged: VoidClosure?
    var isLoadingChanged: VoidClosure?
    var historyChanged: VoidClosure?
    
    var query: String? {
        didSet {
            guard let query = query else {
                return
            }
            isLoading = true
            dataProvider.fetchFilms(query: query, page: 1) { (result) in
                switch result {
                case .success(let value):
                    self.result = value
                    self.updateQueriesHistory(newQuery: query)
                case .error(let error):
                    self.error = error
                }
            }
        }
    }
    
    private (set) var result: PageEntity<FilmInfoEnity>? {
        didSet {
            isLoading = false
            searchResultChanged?()
        }
    }
    
    private (set) var error: Error? {
        didSet {
            isLoading = false
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
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
        lastSuccessfulQueries = []
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
