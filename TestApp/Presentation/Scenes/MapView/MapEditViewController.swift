//
//  MapEditViewController.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/23.
//

import UIKit

protocol MapEditViewCotrollerDelegate: AnyObject {
    func halfHeightDidChange(isOn: Bool)
}

final class MapEditViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private let titles: [String] = ["Half Height"]
    weak var delegate: MapEditViewCotrollerDelegate?
    var isHalfHeight = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private func setupView() {
        navigationItem.title = "Map Edit"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(R.nib.switchCell)
        tableView.tableFooterView = UIView()
    }
}

extension MapEditViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.switchCell, for: indexPath)!
        cell.delegate = self
        cell.titleLabel.text = titles[indexPath.row]
        cell.switchButton.isOn = isHalfHeight
        return cell
    }
}

extension MapEditViewController: UITableViewDelegate {}

extension MapEditViewController: SwitchCellDelegate {
    func switchDidChange(isOn: Bool) {
        delegate?.halfHeightDidChange(isOn: isOn)
        dismiss(animated: true)
    }
}
