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
            searchField?.delegate = self
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
        tableView?.isHidden = true
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
