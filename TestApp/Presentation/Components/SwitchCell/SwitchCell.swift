//
//  SwitchCell.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/23.
//

import UIKit

protocol SwitchCellDelegate: AnyObject {
    func switchDidChange(isOn: Bool)
}

class SwitchCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var switchButton: UISwitch!
    
    weak var delegate: SwitchCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func switchDidChange(_ sender: UISwitch) {
        delegate?.switchDidChange(isOn: sender.isOn)
    }
}
