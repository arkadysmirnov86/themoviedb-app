//
//  SearchViewController.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var viewModel: SearchViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        self.viewModel = SearchViewModel(dataProvider: DataProvider())
        viewModel?.errorReceived = {
            [weak self] in
            self?.showError()
        }
        viewModel?.resultReceived = {
            [weak self] in
            self?.updateUI()
        }
        
        viewModel?.isLoadingChanged = {
            [weak self] in
            
        }
        
    }
    
    private func updateUI() {
        
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "error", message: "error message", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction.init(title: "ok", style: UIAlertActionStyle.default, handler: nil))
    }
}
