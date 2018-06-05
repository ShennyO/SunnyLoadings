import Foundation
import UIKit


public enum Result {
    case success
    case failure
}


public class Loader {
    
    //How do I make a singleton instance when I have to pass in parameters?
    
    public var vc: UIViewController!
    
    //MARK: VIEWS
    var baseView: UIView!
    var colorView: UIView!
    
    //MARK: LAYERS
    var triangleLayerOne: CAShapeLayer!
    var triangleLayerTwo: CAShapeLayer!
    var baseCircleLayer: CAShapeLayer!
    var checkMark: CAShapeLayer!
    var horizontalMark: CAShapeLayer!
    var verticalMark: CAShapeLayer!
    var transparentLayerOne: CAShapeLayer!
    var transparentLayerTwo: CAShapeLayer!
    
    //MARK: ANIMATIONS
    var rotateAnimation: CABasicAnimation!
    
    
    public init(vc: UIViewController) {
        self.vc = vc
    }
    
    public func animateBaseViewLayers(x: CGFloat, y: CGFloat, size: CGFloat) {
        
        //MARK: BASE VIEW (FOR ROTATING, EXPANDING VIEWS)
        
        let baseFrame = CGRect(x: x, y: y, width: size, height: size)
        baseView = UIView(frame: baseFrame)
        //center rearranges the center point of our view
        baseView.center = CGPoint(x: vc.view.bounds.midX, y: vc.view.bounds.midY)
        baseView.layer.cornerRadius = baseFrame.width / 2
        baseView.layer.backgroundColor = vc.view.backgroundColor?.cgColor
        baseView.layer.zPosition = 3
        
        //MARK: COLOR VIEW
        let colorFrame = CGRect(x: x, y: y, width: size - (size * 0.04), height: size - (size * 0.04))
        colorView = UIView(frame: colorFrame)
        colorView.center = CGPoint(x: vc.view.bounds.midX, y: vc.view.bounds.midY)
        colorView.layer.zPosition = 2
        colorView.layer.cornerRadius = colorFrame.width / 2
        colorView.alpha = 0
        
        //MARK: BEZIER PATHS
        
        //circle bezier path for the circle
        let circleWidthHeight = baseFrame.width
        let circlePath = UIBezierPath(ovalIn: CGRect(x: -circleWidthHeight / 2, y: -circleWidthHeight / 2, width: circleWidthHeight, height: circleWidthHeight))
        
        //Right Triangle Bezier Path
        let rightTriangle: UIBezierPath = {
            let triangle = UIBezierPath()
            let rightStartingPoint = CGPoint(x: baseView.bounds.maxX - (baseView.bounds.maxX * 0.14), y: baseView.bounds.midY - (baseView.bounds.midY * 0.2))
            let rightSecondPoint = CGPoint(x: baseView.bounds.maxX + (baseView.bounds.maxX * 0.1266), y: baseView.bounds.midY - (baseView.bounds.midY * 0.2))
            let rightThirdPoint = CGPoint(x: baseView.bounds.maxX - 1, y: baseView.bounds.midY + (baseView.bounds.midY * 0.266))
            triangle.move(to: rightStartingPoint)
            triangle.addLine(to: rightSecondPoint)
            triangle.addLine(to: rightThirdPoint)
            triangle.close()
            return triangle
        }()
        
        //Left Triangle Bezier Path
        let leftTriangle: UIBezierPath = {
            let triangle = UIBezierPath()
            let leftStartingPoint = CGPoint(x: baseView.bounds.minX + (baseView.bounds.maxX * 0.14), y: baseView.bounds.midY + (baseView.bounds.midY * 0.2))
            let leftSecondPoint = CGPoint(x: baseView.bounds.minX - (baseView.bounds.maxX * 0.1266), y: baseView.bounds.midY + (baseView.bounds.midY * 0.2))
            let leftThirdPoint = CGPoint(x: baseView.bounds.minX + 1, y: baseView.bounds.midY - (baseView.bounds.midY * 0.266))
            triangle.move(to: leftStartingPoint)
            triangle.addLine(to: leftSecondPoint)
            triangle.addLine(to: leftThirdPoint)
            triangle.close()
            return triangle
        }()
        
        //MARK: END BEZIER PATHS
        //we only need three bezier paths, the circle, and the two triangles.
        //we can make our transparent circle layers through the circle bezier path
        
        
        //MARK: CASHAPELAYERS
        
        // adding the right triangle layer
        triangleLayerOne = CAShapeLayer()
        triangleLayerOne.path = rightTriangle.cgPath
        triangleLayerOne.strokeColor = UIColor.white.cgColor
        triangleLayerOne.fillColor = UIColor.white.cgColor
        triangleLayerOne.zPosition = 5
        
        // adding the left triangle layer
        triangleLayerTwo = CAShapeLayer()
        triangleLayerTwo.path = leftTriangle.cgPath
        triangleLayerTwo.strokeColor = UIColor.white.cgColor
        triangleLayerTwo.fillColor = UIColor.white.cgColor
        triangleLayerTwo.zPosition = 5
        
        // full circle layer
        baseCircleLayer = CAShapeLayer()
        baseCircleLayer.path = circlePath.cgPath
        baseCircleLayer.position = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
        baseCircleLayer.fillColor = UIColor.clear.cgColor
        baseCircleLayer.strokeColor = UIColor.white.cgColor
        baseCircleLayer.lineWidth = baseView.bounds.width * 0.10466
        
        
        //adding the transparent curve one (using the circle path
        transparentLayerOne = CAShapeLayer()
        transparentLayerOne.position = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
        transparentLayerOne.path = circlePath.cgPath
        transparentLayerOne.fillColor = UIColor.clear.cgColor
        transparentLayerOne.strokeColor = vc.view.backgroundColor?.cgColor
        transparentLayerOne.lineWidth = baseView.bounds.width * 0.12
        transparentLayerOne.strokeStart = 0.5
        transparentLayerOne.strokeEnd = 0.6
        transparentLayerOne.zPosition = 4
        
        
        //adding the transparent curve two
        transparentLayerTwo = CAShapeLayer()
        transparentLayerTwo.position = CGPoint(x: baseView.bounds.midX, y: baseView.bounds.midY)
        transparentLayerTwo.path = circlePath.cgPath
        transparentLayerTwo.fillColor = UIColor.clear.cgColor
        transparentLayerTwo.strokeColor = vc.view.backgroundColor?.cgColor
        transparentLayerTwo.lineWidth = baseView.bounds.width * 0.12
        transparentLayerTwo.strokeStart = 0
        transparentLayerTwo.strokeEnd = 0.1
        transparentLayerTwo.zPosition = 4
        
        vc.view.addSubview(baseView)
        baseView.layer.addSublayer(transparentLayerOne)
        baseView.layer.addSublayer(transparentLayerTwo)
        baseView.layer.addSublayer(baseCircleLayer)
        baseView.layer.addSublayer(triangleLayerOne)
        baseView.layer.addSublayer(triangleLayerTwo)
        animate()
    }
    
    //animating the baseview layers
    private func animate() {
        let strokeStartAnim = CABasicAnimation()
        strokeStartAnim.toValue = 0.5
        strokeStartAnim.repeatCount = Float(Int.max)
        strokeStartAnim.keyPath = #keyPath(CAShapeLayer.strokeStart)
        
        let strokeEndAnim = CABasicAnimation()
        strokeEndAnim.toValue = 0.9
        strokeEndAnim.repeatCount = Float(Int.max)
        strokeEndAnim.keyPath = #keyPath(CAShapeLayer.strokeEnd)
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [strokeStartAnim, strokeEndAnim]
        groupAnim.duration = 0.6
        groupAnim.beginTime = 0
        groupAnim.speed = 1
        groupAnim.autoreverses = true
        groupAnim.repeatCount = .greatestFiniteMagnitude
        baseView.layer.sublayers![0].add(groupAnim, forKey: "groupAnimation")
        
        
        let strokeStartAnimTwo = CABasicAnimation()
        strokeStartAnimTwo.toValue = 0
        strokeStartAnimTwo.repeatCount = Float(Int.max)
        strokeStartAnimTwo.keyPath = #keyPath(CAShapeLayer.strokeStart)
        
        let strokeEndAnimTwo = CABasicAnimation()
        strokeEndAnimTwo.toValue = 0.4
        strokeStartAnimTwo.repeatCount = Float(Int.max)
        strokeEndAnimTwo.keyPath = #keyPath(CAShapeLayer.strokeEnd)
        
        let groupAnimTwo = CAAnimationGroup()
        groupAnimTwo.animations = [strokeStartAnimTwo, strokeEndAnimTwo]
        groupAnimTwo.duration = 0.6
        groupAnimTwo.beginTime = 0
        groupAnimTwo.speed = 1
        groupAnimTwo.autoreverses = true
        groupAnimTwo.repeatCount = .greatestFiniteMagnitude
        baseView.layer.sublayers![1].add(groupAnimTwo, forKey: "groupAnimationTwo")
        
        rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(Double.pi * 2)
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.duration = 1.25
        rotateAnimation.repeatCount = Float.infinity
        baseView.layer.add(rotateAnimation, forKey: "rotation")
        
    }
    
    
    //animating the filling in of the circle border layers
    private func endAnimations(completion: @escaping() -> ()) {
        
        
        let strokeStartAnim = CABasicAnimation()
        strokeStartAnim.toValue = 0.485
        strokeStartAnim.keyPath = #keyPath(CAShapeLayer.strokeStart)
        
        let strokeEndAnim = CABasicAnimation()
        strokeEndAnim.toValue = 0.485
        strokeEndAnim.keyPath = #keyPath(CAShapeLayer.strokeEnd)
        
        let groupAnim = CAAnimationGroup()
        groupAnim.animations = [strokeStartAnim, strokeEndAnim]
        groupAnim.duration = 2
        groupAnim.beginTime = 0
        groupAnim.speed = 1
        baseView.layer.sublayers![0].add(groupAnim, forKey: "groupEndAnimation")
        
        
        
        let strokeStartAnimTwo = CABasicAnimation()
        strokeStartAnimTwo.toValue = 0
        strokeStartAnimTwo.keyPath = #keyPath(CAShapeLayer.strokeStart)
        
        let strokeEndAnimTwo = CABasicAnimation()
        strokeEndAnimTwo.toValue = 0
        strokeEndAnimTwo.keyPath = #keyPath(CAShapeLayer.strokeEnd)
        
        let groupAnimTwo = CAAnimationGroup()
        groupAnimTwo.animations = [strokeStartAnimTwo, strokeEndAnimTwo]
        groupAnimTwo.duration = 2
        groupAnimTwo.beginTime = 0
        groupAnimTwo.speed = 1
        baseView.layer.sublayers![1].add(groupAnimTwo, forKey: "groupEndAnimationTwo")
        completion()
    }
    
    private func createXMark() {
        let horizontalMarkPath = UIBezierPath()
        let horizontalStartingPoint = CGPoint(x: 0, y: baseView.bounds.height * -0.2)
        let horizontalSecondPoint = CGPoint(x: 0, y: baseView.bounds.height * 0.2)
        
        horizontalMarkPath.move(to: horizontalStartingPoint)
        horizontalMarkPath.addLine(to: horizontalSecondPoint)
        
        let verticalMarkPath = UIBezierPath()
        let verticalStartingPoint = CGPoint(x: 0, y: baseView.bounds.height * -0.2)
        let verticalSecondPoint = CGPoint(x: 0, y: baseView.bounds.height * 0.2)
        
        verticalMarkPath.move(to: verticalStartingPoint)
        verticalMarkPath.addLine(to: verticalSecondPoint)
        
        
        horizontalMark = CAShapeLayer()
        horizontalMark.path = horizontalMarkPath.cgPath
        horizontalMark.fillColor = colorView.backgroundColor?.cgColor
        horizontalMark.strokeColor = UIColor.white.cgColor
        horizontalMark.lineWidth = 10
        horizontalMark.zPosition = 10
        horizontalMark.position = CGPoint(x: colorView.bounds.midX, y: colorView.bounds.midY)
        horizontalMark.transform = CATransform3DMakeRotation(CGFloat(45 * (Double.pi / 180)), 0, 0, 1.0)
        
        colorView.layer.addSublayer(horizontalMark)
        
        
        verticalMark = CAShapeLayer()
        verticalMark.path = verticalMarkPath.cgPath
        verticalMark.fillColor = colorView.backgroundColor?.cgColor
        verticalMark.strokeColor = UIColor.white.cgColor
        verticalMark.lineWidth = 10
        verticalMark.zPosition = 10
        verticalMark.position = CGPoint(x: colorView.bounds.midX, y: colorView.bounds.midY)
        verticalMark.transform = CATransform3DMakeRotation(CGFloat(-45 * (Double.pi / 180)), 0, 0, 1.0)
        colorView.layer.addSublayer(verticalMark)
        
    }
    
    private func createCheckMark() {
        let checkmarkPath = UIBezierPath()
        let checkStartingPoint = CGPoint(x: 0, y: 0)
        let checkSecondPoint = CGPoint(x: 0, y: baseView.bounds.height * 0.161)
        let checkThirdPoint = CGPoint(x: baseView.bounds.height * 0.4, y: baseView.bounds.height * 0.161)
        checkmarkPath.move(to: checkStartingPoint)
        checkmarkPath.addLine(to: checkSecondPoint)
        checkmarkPath.addLine(to: checkThirdPoint)
        
        checkMark = CAShapeLayer()
        checkMark.path = checkmarkPath.cgPath
        checkMark.fillColor = colorView.backgroundColor?.cgColor
        checkMark.strokeColor = UIColor.white.cgColor
        checkMark.lineWidth = 10
        checkMark.zPosition = 10
        checkMark.position = CGPoint(x: colorView.bounds.midX - 25, y: colorView.bounds.midY + 5)
        checkMark.transform = CATransform3DMakeRotation(CGFloat(-45 * (Double.pi / 180)), 0, 0, 1.0)
        colorView.layer.addSublayer(checkMark)
        
    }
    
    private func removeTransparentLayers(completion: @escaping ()->()) {
        self.transparentLayerOne.removeFromSuperlayer()
        self.transparentLayerTwo.removeFromSuperlayer()
        completion()
    }
    
    public func stopAllAnimations(result: Result) {
        
        vc.view.addSubview(colorView)
        
        switch result {
        case .success:
            colorView.backgroundColor = UIColor.green
            createCheckMark()
        case .failure:
            colorView.backgroundColor = UIColor(red: 255/255 , green: 82/255, blue: 74/255, alpha: 1)
            createXMark()
        }
        
        
        //animating the connection of the base circle view
        self.endAnimations() {
            //at this point, the circle should already be connected
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                //thinning out the width of the circle and removing the transparent layers
                let strokeWidth = CABasicAnimation()
                strokeWidth.keyPath = #keyPath(CAShapeLayer.lineWidth)
                strokeWidth.toValue = 0
                strokeWidth.duration = 0.7
                self.baseView.layer.sublayers![2].add(strokeWidth, forKey: "shrinkWidth")
                UIView.animate(withDuration: 1.5, animations: {
                    self.baseView.layer.sublayers![2].backgroundColor = self.vc.view.backgroundColor?.cgColor
                })
                
                
                //after thinning the circle border layer, remove the transparent partial circle layers
                self.removeTransparentLayers {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.63, execute: {
                        
                        //removing the base view circle (the layers of the circle)
                        //the triangle, the base circle layer and animations of the baseview
                        self.baseView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
                        
                        UIView.animate(withDuration: 0.6, delay: 0, options: [], animations: {
                            //shrinking the base view(which is transparent) so that the green circle underneath can be shown
                            self.baseView.frame = CGRect(x: self.vc.view.bounds.midX, y: self.vc.view.bounds.midY, width: 0, height: 0)
                            self.baseView.layer.cornerRadius = 0
                            self.colorView.alpha = 1
                            
                            //animate the rotation of the checkmark
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                                if #available(iOS 9.0, *) {
                                    let checkRotation = CASpringAnimation()
                                    checkRotation.keyPath = #keyPath(CAShapeLayer.transform)
                                    checkRotation.fromValue = CATransform3DMakeRotation(CGFloat(-15 * (Double.pi / 180)), 0, 0, 1.0)
                                    checkRotation.toValue = CATransform3DMakeRotation(CGFloat(20 * (Double.pi / 180)), 0, 0, 1.0)
                                    checkRotation.damping = 5
                                    self.colorView.layer.add(checkRotation, forKey: "checkRotation")
                                } else {
                                    // Fallback on earlier versions
                                }
                                
                            })
                            
                        }, completion: { (bool) in
                            
                            
                            //after the checkmark animation and shrinking of the baseView, fade out the colorView and remove the two views
                            UIView.animate(withDuration: 0.5, delay: 0.8, options: [], animations: {
                                
                                self.colorView.alpha = 0
                            }, completion: { (bool) in
                                self.baseView.removeFromSuperview()
                                self.colorView.removeFromSuperview()
                                return
                            })
                            
                            return
                        })
                        
                    })
                }
            }
            
        }
    }
    
    func removeAnimationViews() {
        self.baseView.removeFromSuperview()
        self.colorView.removeFromSuperview()
    }
    
    
}
