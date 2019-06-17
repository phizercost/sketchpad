//
//  DrawingViewController.swift
//  Sketchpad
//
//  Created by Phizer Cost on 6/17/19.
//  Copyright © 2019 Phizer Cost. All rights reserved.
//

import UIKit
import ChromaColorPicker

class DrawingViewController: UIViewController, ChromaColorPickerDelegate {
    

    @IBOutlet weak var imageView: UIImageView!
    var lastPoint: CGPoint = CGPoint(x:0, y:0)
    var currentColor = UIColor.blue.cgColor
    var brushSize: Float = 30.0
    var colorPicker: ChromaColorPicker?
    var greyedOut = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        greyedOut = UIView(frame: view.frame)
        greyedOut.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        view.addSubview(greyedOut)

        colorPicker = ChromaColorPicker(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        if let picker = colorPicker {
            picker.delegate = self
            picker.padding = 5
            picker.stroke = 3
            picker.hexLabel.isHidden = true
            view.addSubview(picker)
        }
        colorPicker?.isHidden = true
        greyedOut.isHidden = true
        
    }
    func colorPickerDidChooseColor(_ colorPicker: ChromaColorPicker, color: UIColor) {
        currentColor = color.cgColor
        colorPicker.isHidden = true
        greyedOut.isHidden = true
    }
    
    @IBAction func colorTapped(_ sender: Any) {
        colorPicker?.adjustToColor(UIColor(cgColor: currentColor))
        colorPicker?.isHidden = false
         greyedOut.isHidden = false
    }
    
    @IBAction func sizeTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Brush Size", message: "\n\n\n\n\n\n\n", preferredStyle: .alert)
        let slider = UISlider(frame: CGRect(x: 10, y: 50, width: 250, height: 80))
        slider.minimumValue = 1
        slider.maximumValue = 100
        slider.value = brushSize
        alert.view.addSubview(slider)
        let okAction = UIAlertAction(title: "OK", style: .default) { (al) in
            self.brushSize = slider.value
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func eraseTapped(_ sender: Any) {
        currentColor = UIColor.white.cgColor
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
            context.setLineWidth(CGFloat(brushSize) / 3.0)
            context.setLineCap(.round)
            context.setStrokeColor(currentColor)
            context.strokePath()
            imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        
    }

}
