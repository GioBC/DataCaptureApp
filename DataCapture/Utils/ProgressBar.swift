//
//  ProgressBar.swift
//  DataCapture
//
//  Created by Yermis Beltran on 6/03/22.
//

import UIKit

class ProgressBar: UIView {
    
    @IBInspectable public lazy var backgroundCircleColor: UIColor = UIColor.lightGray
    @IBInspectable public lazy var foregroundCircleColor: UIColor = UIColor.red
    @IBInspectable public lazy var startGradientColor: UIColor = UIColor.red
    @IBInspectable public lazy var endGradientColor: UIColor = UIColor.orange
    @IBInspectable public lazy var textColor: UIColor = UIColor.white
    
    private lazy var fillColor: UIColor = UIColor.clear
    
    private var backgroundLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    private var foregroundLayer: CAShapeLayer!
    private var textLayer: CATextLayer!
    
    public var progress: CGFloat = 0 {
        didSet {
            didProgressUpdated()
        }
    }
    
    override func draw(_ rect: CGRect) {
        guard layer.sublayers == nil else {
            return
        }
        
        let lineWidth = min(frame.size.width, frame.size.height) * 0.1
        
        backgroundLayer = createCircularLayer(strokeColor: backgroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        
        progressLayer = createCircularLayer(strokeColor: foregroundCircleColor.cgColor, fillColor: fillColor.cgColor, lineWidth: lineWidth)
        progressLayer.strokeEnd = progress
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        
        gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.mask = progressLayer
        
        layer.addSublayer(backgroundLayer)
        layer.addSublayer(gradientLayer)
        layer.addSublayer(textLayer)
    }
    
    private func createCircularLayer(strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer {
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = 2 * CGFloat.pi + startAngle
        
        let width = frame.size.width
        let height = frame.size.height
        
        let center = CGPoint(x: width / 2, y: height / 2)
        let radius = (min(width, height) - lineWidth) / 2
        
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.fillColor = fillColor
        shapeLayer.lineCap = .round
        
        return shapeLayer
    }
    
    private func didProgressUpdated() {
        
        textLayer?.string = "\(Int(progress * 100))"
        progressLayer?.strokeEnd = progress
    }
    
    /*private func createTextLayer(textColor: UIColor) -> CATextLayer {
     
     let width = frame.size.width
     let height = frame.size.height
     
     let fontSize = min(width, height) / 4 - 5
     let offset = min(width, height) * 0.1
     
     let layer = CATextLayer()
     layer.string = "\(Int(progress * 100))"
     layer.backgroundColor = UIColor.clear.cgColor
     layer.foregroundColor = textColor.cgColor
     layer.fontSize = fontSize
     layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: height)
     layer.alignmentMode = .center
     
     return layer
     }*/
}


