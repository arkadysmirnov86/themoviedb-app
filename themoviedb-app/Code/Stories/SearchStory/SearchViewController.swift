//
//  SearchViewController.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    let viewModel = SearchViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.errorReceived = {
            [weak self] in
            self?.showError()
        }
        viewModel.resultReceived = {
            [weak self] in
            self?.updateUI()
        }
    }
    
    private func updateUI() {
        
    }
    
    private func showError() {
        
    }
}
