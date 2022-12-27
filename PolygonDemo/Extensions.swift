//
//  Extensions.swift
//  PolygonDemo
//
//  Created by Ankush on 27/12/22.
//

import Foundation
import UIKit

extension UIColor {
    static func random() -> UIColor {
        return UIColor(
           red:   .random(),
           green: .random(),
           blue:  .random(),
           alpha: 1.0
        )
    }
}

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
}

extension CGPoint {
    
    func isInsidePolygon(vertices: [CGPoint]) -> Bool {
        guard vertices.count > 0 else { return false }
        var i = 0, j = vertices.count - 1, c = false, vi: CGPoint, vj: CGPoint
        while true {
            guard i < vertices.count else { break }
            vi = vertices[i]
            vj = vertices[j]
            if (vi.y > y) != (vj.y > y) &&
                x < (vj.x - vi.x) * (y - vi.y) / (vj.y - vi.y) + vi.x {
                c = !c
            }
            j = i
            i += 1
        }
        return c
    }
}


extension UIViewController {

    func showToast(message : String, colorCustom: UIColor) {

    let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 175 , y: self.view.frame.size.height-140, width: 350, height: 46))
    toastLabel.backgroundColor = colorCustom
    toastLabel.textColor = UIColor.white
    toastLabel.font = UIFont(name: "NeoSansPro-Medium", size: 14)
    toastLabel.textAlignment = .center;
    toastLabel.text = message
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 10;
    toastLabel.clipsToBounds  =  true
    self.view.addSubview(toastLabel)
    UIView.animate(withDuration: 1.0, delay: 0.1, options: .curveEaseOut, animations: {
         toastLabel.alpha = 0.0
    }, completion: {(isCompleted) in
        toastLabel.removeFromSuperview()
    })
}
    
}
