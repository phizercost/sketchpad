//
//  DrawingViewController.swift
//  Sketchpad
//
//  Created by Phizer Cost on 6/17/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit

class DrawingViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var lastPoint: CGPoint = CGPoint(x:0, y:0)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let beginPoint = touches.first?.location(in: imageView) {
            lastPoint = beginPoint
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let movedPoint = touches.first?.location(in: imageView) {
            drawBetweenTwoPoints(point1:lastPoint, point2: movedPoint)
            lastPoint = movedPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let endPoint = touches.first?.location(in: imageView) {
           drawBetweenTwoPoints(point1:lastPoint, point2: endPoint)
            
        }
    }
    
    func drawBetweenTwoPoints(point1:CGPoint, point2:CGPoint){
        UIGraphicsBeginImageContext(imageView.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: imageView.frame.size.width, height: imageView.frame.size.height))
        if let context = UIGraphicsGetCurrentContext() {
            context.move(to: point1)
            context.addLine(to: point2)
            context.setLineWidth(10)
            context.setLineCap(.round)
            context.setStrokeColor(UIColor.red.cgColor)
            context.strokePath()
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
    }

}
