//
//  SearchViewModel.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var errorReceived: VoidClosure?
    var resultReceived: VoidClosure?
    
    private var dataProvider: DataProviderProtocol
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    var query: String? {
        didSet {
            guard let query = query else {
                return
            }
            
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
            resultReceived?()
        }
    }
    private (set) var error: Error? {
        didSet {
            errorReceived?()
        }
    }
}
