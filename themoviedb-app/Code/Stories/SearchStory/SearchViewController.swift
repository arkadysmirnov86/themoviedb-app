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
            configureSearchField()
        }
    }
    
    @IBOutlet private weak var tableView: UITableView? {
        didSet {
            configureTableView()
        }
    }
    
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView? {
        didSet {
            activityIndicator?.stopAnimating()
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
            if self?.viewModel?.isLoading ?? false {
                self?.activityIndicator?.startAnimating()
            } else {
                self?.activityIndicator?.stopAnimating()
            }
        }
        viewModel?.historyChanged = {
            [weak self] in
            self?.tableView?.reloadData()
        }
        
    }
    
    private func showError() {
        let alertController = UIAlertController(title: "error", message: "error message", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction.init(title: "ok", style: UIAlertActionStyle.default, handler: nil))
    }
    
    private func configureTableView() {
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: .cellReuseIdentifier)
        tableView?.dataSource = self
        tableView?.delegate = self
        tableView?.isHidden = true
    }
    
    private func configureSearchField() {
        searchField?.delegate = self
        searchField?.clearButtonMode = .always
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.history.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: .cellReuseIdentifier) ?? UITableViewCell()
        
        cell.textLabel?.text = self.viewModel?.history[indexPath.row]
        cell.imageView?.image = #imageLiteral(resourceName: "icons8-search-2")
        
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchField?.resignFirstResponder()
        let cell = tableView.cellForRow(at: indexPath)
        if let query = cell?.textLabel?.text {
            self.viewModel?.query = query
            self.searchField?.text = query
        }
        cell?.isSelected = false
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        tableView?.isHidden = false
        tableView?.reloadData()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.viewModel?.query = textField.text
        textField.resignFirstResponder()
        return true
    }
    
}

private extension String {
    static let cellReuseIdentifier = "cell"
}
