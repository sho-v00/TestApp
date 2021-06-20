//
//  PlaceAnnotationView.swift
//  TestApp
//
//  Created by Shota Ito on 2021/06/20.
//

import UIKit
import MapKit

final class PlaceAnnotationView: MKAnnotationView {

    @IBOutlet weak var label: UILabel!

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadFromNib()
    }
    
    private func loadFromNib() {
        let nib = R.nib.placeAnnotationView
        guard let view = nib.instantiate(withOwner: self).first as? UIView else { return }
        view.frame = bounds
        addSubview(view)
    }
}
