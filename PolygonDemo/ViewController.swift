//
//  ViewController.swift
//  PolygonDemo
//
//  Created by Ankush on 27/12/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var BackVw: UIView!
    var cordsArr : [CGPoint] = []
    
    var allowDrawing: Bool = true
    var pointHeightWidth = 14.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func clearBtnAction(_ sender: Any) {
        self.cordsArr.removeAll()
        self.allowDrawing = true
        self.BackVw.subviews.forEach { $0.removeFromSuperview() }
        self.BackVw.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if allowDrawing {
            for touch in touches {
                let location = touch.location(in: self.BackVw)
                
                
                if self.cordsArr.count != 0 {
                    self.drawPoint(location: location)
                    
                    var cords : [CGPoint] = [self.cordsArr.last!]
                    
                    let newpoint: CGPoint = CGPoint(x: location.x + pointHeightWidth/2, y: location.y + pointHeightWidth/2)
                    cords.append(newpoint)
                    
                    self.drawLine(points: cords)
                    self.cordsArr.append(newpoint)
                } else {
                    self.drawPoint(location: location)
                    let newpoint: CGPoint = CGPoint(x: location.x + pointHeightWidth/2, y: location.y + pointHeightWidth/2)
                    self.cordsArr.append(newpoint)
                }
            }
        } else {
            for touch in touches {
                let location = touch.location(in: self.BackVw)
                
                if location.isInsidePolygon(vertices: self.cordsArr) {
                    self.showToast(message: "You have touched inside the polygon.", colorCustom: .green)
                } else {
                    self.showToast(message: "You have touched outside of polygon.", colorCustom: .green)
                }
            }
        }
    }
          
    func drawPoint(location: CGPoint ) {
        let viewC = UIView.init(frame: CGRect(x: location.x, y: location.y, width: pointHeightWidth, height: pointHeightWidth))

        viewC.backgroundColor = UIColor.random()
        viewC.layer.cornerRadius = pointHeightWidth/2
        viewC.clipsToBounds = true
        
        let subVIews = self.BackVw.subviews
            for newView in subVIews {
                if newView.frame.intersects(viewC.frame) {
                    print("ankush")
                    allowDrawing = false
                }
            }
        
        
        self.BackVw.addSubview(viewC)
    }
    
    
    func drawLine(points: [CGPoint])
        {
            guard !points.isEmpty else { return }
            
            let path = UIBezierPath()
            
            // This is actual drawing path using the points
            // I don't see this in your code
            for (index, point) in points.enumerated()
            {
                // first pair of points
                if index == 0
                {
                    // Move to the starting point
                    path.move(to: point)
                    continue
                }
                
                // Draw a line from the previous point to the current
                path.addLine(to: point)
            }
            
            // Create a shape layer to visualize the path
            let shapeLayer = CAShapeLayer()
            shapeLayer.fillColor = UIColor.random().cgColor
            shapeLayer.strokeColor = UIColor.random().cgColor
            shapeLayer.lineWidth = 4
            shapeLayer.path = path.cgPath
            
            self.BackVw.layer.addSublayer(shapeLayer)
        }
}

