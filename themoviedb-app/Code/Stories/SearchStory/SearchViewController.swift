//
//  SearchViewController.swift
//  themoviedb-app
//
//  Created by Arkady Smirnov on 7/31/18.
//  Copyright © 2018 Arkady Smirnov. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet private weak var searchField: UITextField? {
        didSet {
         
        }
    }
    
    @IBOutlet private weak var tableView: UITableView? {
        didSet {
            configureTableView()
        }
    }
    
    var viewModel: SearchViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        viewModel?.errorChanged = {
            [weak self] in
            self?.showError()
        }
        
        viewModel?.isLoadingChanged = {
            [weak self] in
            
        }
        
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "error", message: "error message", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction.init(title: "ok", style: UIAlertActionStyle.default, handler: nil))
    }
    
    private func configureTableView() {
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: .cellReuseIdentifier)
        tableView?.dataSource = self
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseIdentifier) ?? UITableViewCell()
        cell.imageView?.image = UIImage()
        cell.textLabel?.text = self.viewModel?.history[indexPath.row]
        return cell
    }
}

private extension String {
    static let cellReuseIdentifier = "cell"
}
