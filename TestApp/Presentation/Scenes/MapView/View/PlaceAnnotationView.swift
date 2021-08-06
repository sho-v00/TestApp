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
    
    static let height: CGFloat = 53

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        loadFromNib()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        loadFromNib()
    }
    
    private func loadFromNib() {
        let nib = R.nib.placeAnnotationView
        guard let view = nib.instantiate(withOwner: self).first as? UIView else { return }
        bounds = view.bounds
        // make inset cuz the pin's centre is focused
        centerOffset = CGPoint(x: 0, y: -frame.size.height / 2)
        addSubview(view)
    }
    
    // Calloutのタップイベントを検知するための設定
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if hitView == self {
            return nil
        }
        return hitView
    }

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        var isInside = self.bounds.contains(point)
        if !isInside {
            for view in self.subviews {
                isInside = view.frame.contains(point)
                if isInside {
                    break
                }
            }
        }
        return isInside
    }
}
