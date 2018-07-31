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
    
    var errorReceived: VoidClosure?
    var resultReceived: VoidClosure?
    var isLoadingChanged: VoidClosure?
    
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
                case .error(let error):
                        self.error = error
                }
            }
        }
    }
    
    private (set) var result: PageEntity<FilmInfoEnity>? {
        didSet {
            isLoading = false
            resultReceived?()
        }
    }
    
    private (set) var error: Error? {
        didSet {
            isLoading = false
            errorReceived?()
        }
    }
    
    private (set) var isLoading: Bool = false {
        didSet {
            isLoadingChanged?()
        }
    }
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
}
