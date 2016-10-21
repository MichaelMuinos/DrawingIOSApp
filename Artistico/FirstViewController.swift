//
//  FirstViewController.swift
//  Artistico
//
//  Created by Michael Muinos on 10/19/16.
//  Copyright © 2016 Michael Muinos. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    enum BrushType {
        case line
        case circle
        case rectangle
        case eraser
    }

    @IBOutlet weak var imageView: UIImageView!
    
    var red: CGFloat = 0.0
    var green: CGFloat = 0.0
    var blue: CGFloat = 0.0
    var alpha: CGFloat = 1.0
    var lineWidth: CGFloat = 1.0
    
    let imagePicker = UIImagePickerController()
    
    var lastPoint = CGPoint.zero
    var swiped = false
    
    var type = BrushType.line
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
            if(type == BrushType.circle) {
                drawCircle(lastPoint)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if type == BrushType.line || type == BrushType.eraser {
            swiped = true
            if let touch = touches.first {
                let currentPoint = touch.location(in: self.view)
                drawLines(lastPoint, toPoint: currentPoint)
            
                lastPoint = currentPoint
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if type == BrushType.line || type == BrushType.eraser {
            if !swiped {
                drawLines(lastPoint, toPoint: lastPoint)
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func drawLines(_ fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        
        if type == BrushType.line {
            context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
            context?.setLineWidth(lineWidth)
            context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor)
        } else {
            let rectangle = CGRect(x: fromPoint.x, y: fromPoint.y, width: 50, height: 50)
            context?.addRect(rectangle)
            context?.setLineWidth(10)
            context?.setStrokeColor(UIColor(red: 255, green: 255, blue: 255, alpha: 1.0).cgColor)
        }
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    
    func drawCircle(_ fromPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: fromPoint.x, y: fromPoint.y, width: 50, height: 50)
        context?.addEllipse(in: rectangle)
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    func drawRectangle(_ fromPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        let context = UIGraphicsGetCurrentContext()
        let rectangle = CGRect(x: fromPoint.x, y: fromPoint.y, width: 50, height: 50)
        context?.addRect(rectangle)
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(UIColor(red: red, green: green, blue: blue, alpha: alpha).cgColor)
        
        context?.strokePath()
        
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }

    @IBAction func clearButtonClick(_ sender: UIButton) {
        self.imageView.image = nil
    }

    @IBAction func uploadButtonClick(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveButtonClick(_ sender: UIButton) {
    }
    
    @IBAction func eraseButtonClick(_ sender: UIButton) {
        type = BrushType.eraser
    }
    
    @IBAction func colorWheelClick(_ sender: AnyObject) {
        type = BrushType.line
        
        switch sender.tag {
        case 0:
            (red, green, blue) = (1, 0, 0)
        case 1:
            (red, green, blue) = (0, 0, 0)
        case 2:
            (red, green, blue) = (1, 1, 0)
        case 3:
            (red, green, blue) = (0, 1, 1)
        case 4:
            (red, green, blue) = (1, 0, 1)
        case 5:
            (red, green, blue) = (0, 1, 0)
        case 6:
            (red, green, blue) = (0, 0, 1)
        case 7:
            (red, green, blue) = (1, 1, 1)
        default:
            (red, green, blue) = (0, 0, 0)
        }

    }
    
    @IBAction func circleButtonClick(_ sender: UIButton) {
        type = BrushType.circle
    }
    
}

