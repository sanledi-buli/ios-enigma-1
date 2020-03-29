//
//  HomeViewController.swift
//  Training1
//
//  Created by Sanledi Buli on 28/03/20.
//  Copyright © 2020 Working Home. All rights reserved.
//

import UIKit

internal final class HomeViewController: ViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: HomeViewModel?
    
    init(viewModel: HomeViewModel) {
        super.init(nibName: "HomeViewController", bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: HomeTableViewCell.self)
        tableView.tableFooterView = UIView()
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.arrayOfItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HomeTableViewCell  = tableView.dequeueReusableCell(for: indexPath, cellType: HomeTableViewCell.self)
        
        let contact = self.viewModel?.arrayOfItems[indexPath.row]
        cell.contactLabel.text = contact?.contact
        cell.statusLabel.text = contact?.status
        return cell
    }
    
    
}
