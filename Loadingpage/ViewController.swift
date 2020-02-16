//
//  ViewController.swift
//  Loadingpage
//
//  Created by Salamender Li on 16/2/20.
//  Copyright © 2020 Salamender Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var loadinglabel : UILabel = {
          let label = UILabel()
          label.text = "Loading"
          label.textAlignment = .center
          label.textColor = UIColor.backgroundColor
          label.font = UIFont.boldSystemFont(ofSize: 35)
          return label
      }()
      
      let shapeLayer = CAShapeLayer()
      
      let pulsatingLayer =  CAShapeLayer()
      
      let trackLayer = CAShapeLayer()


      override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = UIColor.backgroundColor
        NotificationCenter.default.addObserver(self, selector: #selector(becomeactive(sender:)), name: Notification.Name(rawValue: "App Did Become Active"), object: nil)
          view.addSubview(loadinglabel)
            viewWillLayoutSubviews()
            animateLoadingLabel()
      }
      
      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
        print("should run the code here")
          
      }
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
    }
    
      override func viewWillLayoutSubviews() {
            initializeCircleView(position: view.center)
            animateShapeLayer()
            animatePulsatingLayer()
            loadinglabel.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
            loadinglabel.center = view.center
            view.bringSubviewToFront(loadinglabel)
      }

      ///Progress Circle
      //https://www.youtube.com/watch?v=O3ltwjDJaMk
      func initializeCircleView(position: CGPoint) {
          
          let width = (self.view.frame.width < self.view.frame.height) ? self.view.frame.width/3 : self.view.frame.height/3
          let circlarPath = UIBezierPath(arcCenter: .zero, radius: width, startAngle: 0, endAngle: 2.0*CGFloat.pi, clockwise: true)
          pulsatingLayer.path = circlarPath.cgPath
          
          pulsatingLayer.lineWidth = 35
          
          pulsatingLayer.fillColor = UIColor.shapeLayerColor.withAlphaComponent(0.4).cgColor
          
          pulsatingLayer.lineCap = CAShapeLayerLineCap.round

          pulsatingLayer.position = position
          
          if view.layer.sublayers!.contains(pulsatingLayer) == false{
              view.layer.addSublayer(pulsatingLayer)
          }
          trackLayer.path = circlarPath.cgPath
          
          trackLayer.strokeColor =  UIColor.strokeColor.cgColor
          trackLayer.lineWidth = 35
          
          trackLayer.fillColor = UIColor.fillcolor.cgColor
          
          trackLayer.lineCap = CAShapeLayerLineCap.round
          trackLayer.position = position
          
          trackLayer.shadowOffset = CGSize(width: 0, height: 5)
          trackLayer.shadowRadius = 5
          trackLayer.shadowOpacity = 0.3
          trackLayer.shadowColor = UIColor.lightGray.cgColor
          
          if view.layer.sublayers!.contains(trackLayer) == false{
              view.layer.addSublayer(trackLayer)
          }
          shapeLayer.path = circlarPath.cgPath
          
          shapeLayer.strokeColor = UIColor.shapeLayerColor.cgColor
          shapeLayer.lineWidth = 35
          shapeLayer.borderColor = UIColor.black.cgColor
          shapeLayer.borderWidth = 1
          shapeLayer.fillColor = UIColor.clear.cgColor
          shapeLayer.lineCap = CAShapeLayerLineCap.round
          shapeLayer.strokeEnd = 0
          shapeLayer.position = position
          shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
          
          if view.layer.sublayers!.contains(shapeLayer) == false{
              view.layer.addSublayer(shapeLayer)
          }
      }
      
      func animatePulsatingLayer(){
          let animation = CABasicAnimation(keyPath: "transform.scale")
          animation.toValue = 1.3
          animation.duration = 0.9
          animation.autoreverses = true
          animation.repeatCount = Float.infinity
          if pulsatingLayer.animation(forKey: "pulsating") == nil{
          pulsatingLayer.add(animation, forKey: "pulsating")
          }
      }
      
      func animateShapeLayer(){
          let basicAnimation =  CABasicAnimation(keyPath: "strokeEnd")
          basicAnimation.toValue = 1
          basicAnimation.duration = 1.5
          basicAnimation.fillMode = CAMediaTimingFillMode.forwards
          basicAnimation.isRemovedOnCompletion = true
          basicAnimation.repeatCount = Float.infinity
          if shapeLayer.animation(forKey: "shapeLaype") == nil {
          shapeLayer.add(basicAnimation, forKey: "shapeLaype")
          }
      }
    
    func animateLoadingLabel(){
        var count = 0
        let symbol = "."
        var appendix = ""
        var loadingtext = "Loading"
        let timer = Timer.scheduledTimer(withTimeInterval: 0.8, repeats: true) { (timer) in
            count = (count >= 4) ? (count + 1)%4 : count + 1
            for i in 0..<count{
                appendix.append(symbol)
                if i == 0{
                    appendix.removeAll()
                }
            }
            self.loadinglabel.text = loadingtext + appendix
        }
    }
      
      override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
          self.view.layoutIfNeeded()
          self.view.layoutSubviews()
      }
      
    @objc func becomeactive(sender:NSNotification) {
        print("becomeactive")
        self.viewWillLayoutSubviews()
    }

}

