//
//  MovieListCoordinator.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/2/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class MovieListCoordinator: Coordinator {
    
    let navigationController: UINavigationController
    let dataProvider: DataProviderProtocol
    let firstPage: PageModel<MovieModel>
    let query: String
    
    init(navigationController: UINavigationController, dataProvider: DataProviderProtocol, query: String, firstPage: PageModel<MovieModel>) {
        self.navigationController = navigationController
        self.dataProvider = dataProvider
        self.query = query
        self.firstPage = firstPage
        
    }
    
    func start() {
        let viewModel = MovieListViewModel()
        viewModel.pages = [firstPage]
        viewModel.query = query
        
        let viewController = self.instantiate(MovieListViewController.self)
        viewController.title = query
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
