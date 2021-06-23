//
//  MapEditViewController.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/23.
//

import UIKit

protocol MapEditViewCotrollerDelegate: AnyObject {
    func changeHeightDidTap()
}

final class MapEditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let titles: [String] = ["Change Map height"]
    weak var delegate: MapEditViewCotrollerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Map Edit"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.normalCell)
        tableView.tableFooterView = UIView()
    }
}

extension MapEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.normalCell, for: indexPath)!
        cell.titleLabel.text = titles[indexPath.row]
        return cell
    }
}

extension MapEditViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.changeHeightDidTap()
        dismiss(animated: true)
    }
}
