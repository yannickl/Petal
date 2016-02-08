/**
 * Petal
 *
 * Copyright 2016-present Yannick Loriot.
 * http://yannickloriot.com
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 */


import UIKit
import QuartzCore

@IBDesignable public final class Petal: UIView {
  @IBInspectable public var segmentCount: UInt       = 15
  @IBInspectable public var rotationDuration: Double = 12
  @IBInspectable public var colors: [UIColor]        = [] {
    didSet {
      setupLayers()
    }
  }

  @IBInspectable public var maxPistilRadiusRatio: CGFloat = 0.4

  var petals: [CAShapeLayer]  = []
  var pistils: [CAShapeLayer] = []

  private(set) var animating: Bool = false

  public override func awakeFromNib() {
    super.awakeFromNib()

    setupLayers()
  }

  public func startAnimating() {
    guard !animating else {
      return
    }

    animating = true

    let scaleAnim                 = CABasicAnimation(keyPath: "transform.scale")
    scaleAnim.fromValue           = 0
    scaleAnim.toValue             = 1
    scaleAnim.duration            = 0.2
    scaleAnim.fillMode            = kCAFillModeForwards
    scaleAnim.removedOnCompletion = false

    layer.addAnimation(scaleAnim, forKey: "scale")

    /*if layer.speed == 0 {
    let timeSincePause = CACurrentMediaTime() - layer.timeOffset
    layer.timeOffset   = 0
    layer.beginTime    = timeSincePause
    }

    layer.speed = 1*/

    prepareAnimations()
  }

  public func stopAnimating() {
    guard animating else {
      return
    }

    /*if !hidesWhenStopped {
    let pausedTime   = layer.convertTime(CACurrentMediaTime(), fromLayer: nil)
    layer.speed      = 0
    layer.timeOffset = pausedTime
    }*/

    let scaleAnim                 = CABasicAnimation(keyPath: "transform.scale")
    scaleAnim.fromValue           = 1
    scaleAnim.toValue             = 0
    scaleAnim.duration            = 0.2
    scaleAnim.fillMode            = kCAFillModeForwards
    scaleAnim.removedOnCompletion = false

    layer.addAnimation(scaleAnim, forKey: "scale")

    animating = false
  }

  // MARK: -

  func prepareAnimations() {
    let beginTime = CACurrentMediaTime()

    if layer.animationForKey("rotation") == nil {
      let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")

      rotationAnimation.fromValue   = 0
      rotationAnimation.toValue     = CGFloat(M_PI * 2)
      rotationAnimation.duration    = rotationDuration
      rotationAnimation.repeatCount = HUGE
      rotationAnimation.beginTime   = beginTime

      layer.addAnimation(rotationAnimation, forKey: "rotation")
    }

    let morphingDuration = rotationDuration / 4
    let morphingMod      = Double(segmentCount) / 4

    for i in 0 ..< segmentCount {
      let timeOffset = beginTime + (morphingDuration / morphingMod) * (Double(i) % morphingMod)

      let petalAnim    = PetalAnimation.animationWithDuration(morphingDuration, beginTime: beginTime, timeOffset: timeOffset)
      petalAnim.values = [0.8, 1, 0.8].map { pathForPetalAt(i, radiusRatio: $0) }

      let pistilAnim    = PetalAnimation.animationWithDuration(morphingDuration, beginTime: beginTime, timeOffset: timeOffset)
      pistilAnim.values = [0.2, 0.4, 0.2].map { pathForPetalAt(i, radiusRatio: $0, angleOffset: CGFloat(M_PI)) }

      if petals[Int(i)].animationForKey("morphing") == nil {
        petals[Int(i)].addAnimation(petalAnim, forKey: "morphing")
      }

      if pistils[Int(i)].animationForKey("morphing") == nil {
        pistils[Int(i)].addAnimation(pistilAnim, forKey: "morphing")
      }
    }
  }

  func pathForPetalAt(index: UInt, radiusRatio: CGFloat, angleOffset: CGFloat = 0) -> CGPath {
    let center     = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    let startAngle = angleOffset + CGFloat(M_PI * 2 / Double(segmentCount)) * CGFloat(index)
    let endAngle   = angleOffset + CGFloat(M_PI * 2 / Double(segmentCount)) * CGFloat(index + 1)

    return petalPathAtCenter(center, radiusRatio: radiusRatio, startAngle: startAngle, endAngle: endAngle)
  }

  func petalPathAtCenter(center: CGPoint, radiusRatio: CGFloat, startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
    let radius = min(bounds.width / 2, bounds.height / 2) * radiusRatio

    let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    path.addLineToPoint(center)
    path.closePath()

    return path.CGPath
  }

  func setupLayers() {
    layer.removeAllAnimations()

    for petal in petals {
      petal.removeFromSuperlayer()
    }

    for pistil in pistils {
      pistil.removeFromSuperlayer()
    }

    petals.removeAll()
    pistils.removeAll()

    for i in 0 ..< segmentCount {
      let petalLayer       = CAShapeLayer()
      petalLayer.fillColor = colors[Int(i) % colors.count].CGColor

      let pistilLayer       = CAShapeLayer()
      pistilLayer.fillColor = colors[Int(i) % colors.count].CGColor

      petals.append(petalLayer)
      pistils.append(pistilLayer)

      layer.addSublayer(petalLayer)
      layer.addSublayer(pistilLayer)
    }
    
    layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
  }
}
