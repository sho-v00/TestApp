//
//  HomeViewController.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/17.
//

import UIKit

final class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private enum Section: String {
        case mapView
    }
    private var sections: [Section] = [.mapView]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }

    private func setupView() {
        navigationItem.title = "Home"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(R.nib.normalCell)
        tableView.tableFooterView = UIView()
    }
}

extension HomeViewController: UITableViewDelegate {}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.nib.normalCell, for: indexPath)!
        cell.titleLabel.text = sections[indexPath.row].rawValue
        return cell
    }
}

