//
//  ViewController.swift
//  RedditFeeder
//
//  Created by Kiran kumar Sanka on 8/27/21.
//

import UIKit
import Combine

class FeedViewController: UIViewController {
    
    let viewModel = FeedViewModel()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostCell.self, forCellReuseIdentifier: "postCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        subviews()
        constraints()
        tableView.dataSource = self
        tableView.rowHeight =  UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        self.viewModel.delegate = self
        self.tableView.reloadData()
    }
    
    func subviews() {
        view.addSubview(self.tableView)
    }

    func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PostCell else {
            return UITableViewCell()
        }
        cell.viewModel = self.viewModel.posts[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastIndex = self.viewModel.posts.count - 2
        if indexPath.row == lastIndex {
            viewModel.loadNext()
        }
    }
}

extension FeedViewController: FeedViewModelDelegate {
    func reload() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
