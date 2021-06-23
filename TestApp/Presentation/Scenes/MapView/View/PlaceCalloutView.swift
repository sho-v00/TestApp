//
//  PlaceCalloutView.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/21.
//

import UIKit

final class PlaceCalloutView: UIView {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func buttonDidTap(_ sender: Any) {
        print("button was tapped")
    }
}
