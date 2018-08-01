//
//  MovieListViewModel.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/2/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import Foundation

class MovieListViewModel {
    
    var pages: [PageModel<MovieModel>]? {
        didSet {
            
        }
    }
    
    var query: String?
}
