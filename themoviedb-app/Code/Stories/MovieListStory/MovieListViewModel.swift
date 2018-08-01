//
//  MovieListViewModel.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/2/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class MovieListViewModel {
    private var dataProvider: DataProviderProtocol
    private (set) var query: String
    private (set) var pages: [PageModel<MovieModel>] {
        didSet {
            pagesChanged?()
        }
    }
    
    var pagesChanged: VoidClosure?
    
    
    init(dataProvider: DataProviderProtocol, query: String, firstPage: PageModel<MovieModel>) {
        self.dataProvider = dataProvider
        self.pages = [firstPage]
        self.query = query
    }
}
