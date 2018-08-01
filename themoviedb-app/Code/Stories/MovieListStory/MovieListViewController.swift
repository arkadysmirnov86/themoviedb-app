//
//  MovieListViewController.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 8/2/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    var viewModel: MovieListViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    func bindViewModel() {
        viewModel?.errorChanged = {
            [weak self] in
            self?.showError()
        }
        
        viewModel?.pagesChanged = {
            [weak self] in
            self?.updateTable()
        }
        viewModel?.isLoadingChanged = {
            [weak self] in
            self?.showActivityIndicator()
        }
    }
    
    private func showError() {
        
    }
    
    private func updateTable() {
        
    }
    
    private func showActivityIndicator() {
        
    }
}
