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
    private var isLastPageLoaded: Bool = false
    private (set) var query: String
    private (set) var pages: [PageModel<MovieModel>] {
        didSet {
            pagesChanged?()
        }
    }
    
    private (set) var isLoading: Bool = false {
        didSet {
            isLoadingChanged?()
        }
    }
    
    private (set) var error: Error? {
        didSet {
            errorChanged?()
        }
    }
    
    var pagesChanged: VoidClosure?
    var isLoadingChanged: VoidClosure?
    var errorChanged: VoidClosure?
    
    func fetchNextPage() {
        
        guard !isLastPageLoaded else { return }
        
        dataProvider.fetchMovies(query: self.query, page: pages.count) { (result) in
            switch result {
            case .success(let newPageEntity):
                self.isLastPageLoaded = newPageEntity.page == newPageEntity.total_pages
                self.pages.append(newPageEntity.asModel)
                break
            case .error(let error):
                self.error = error
                break
            }
        }
    }
    
    init(dataProvider: DataProviderProtocol, query: String, firstPage: PageModel<MovieModel>) {
        self.dataProvider = dataProvider
        self.pages = [firstPage]
        self.query = query
    }
}
