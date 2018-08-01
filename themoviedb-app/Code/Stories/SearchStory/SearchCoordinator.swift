//
//  SearchCoordinator.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/1/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class SearchCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    var dataProvider: DataProviderProtocol
    
    init(navigationController: UINavigationController, dataProvider: DataProviderProtocol) {
        self.navigationController = navigationController
        self.dataProvider = dataProvider
    }
    
    func start() {
        let viewModel = SearchViewModel(dataProvider: dataProvider)
        viewModel.coordinatorDelegate = self
        let viewController = self.instantiate(SearchViewController.self)
        viewController.viewModel = viewModel
        
        navigationController.pushViewController(viewController, animated: true)
    }
}

protocol SearchCoordinatorDelegate {
    func showSearchResult(query: String, firstPage: PageModel<MovieModel>)
}

extension SearchCoordinator: SearchCoordinatorDelegate {
    func showSearchResult(query: String, firstPage: PageModel<MovieModel>) {
        let movieListCoordinator = MovieListCoordinator(navigationController: self.navigationController, dataProvider: self.dataProvider, query: query, firstPage: firstPage)
        movieListCoordinator.start()
    }
}

