//
// Petal
//
// Copyright 2016-present Yannick Loriot.
// http://yannickloriot.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

import UIKit
import QuartzCore

/**
 Convenience object to create animation to modify the shape of the layer.
 */
final class PetalAnimation {
  /**
   Creates and returns a `CAKeyframeAnimation` object with pre-configured properties.

   - parameter duration: The basic duration of the animation, in seconds.
   - parameter beginTime: The begin time of the receiver in relation to its parent object.
   - parameter timeOffset: Additional time offset in active local time.
   */
  class func animationWithDuration(_ duration: CFTimeInterval, beginTime: CFTimeInterval, timeOffset: CFTimeInterval) -> CAKeyframeAnimation {
    let anim = CAKeyframeAnimation(keyPath: "path")

    anim.keyTimes            = [0, 0.5, 1]
    anim.repeatCount         = HUGE
    anim.duration            = duration
    anim.beginTime           = beginTime
    anim.timeOffset          = timeOffset
    anim.fillMode            = kCAFillModeForwards
    anim.isRemovedOnCompletion = false

    return anim
  }

  /**
   Creates and returns a `CAAnimation` object that allow the receiver to scale up or down.

   - parameter from: The scale at the begining.
   - parameter to: The scale at the end.
   */
  class func scaleAnimationFrom(_ from: CGFloat, to: CGFloat) -> CAAnimation {
    let scaleAnim                 = CABasicAnimation(keyPath: "transform.scale")
    scaleAnim.fromValue           = from
    scaleAnim.toValue             = to
    scaleAnim.duration            = 0.2
    scaleAnim.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    scaleAnim.fillMode            = kCAFillModeForwards
    scaleAnim.isRemovedOnCompletion = false

    return scaleAnim
  }

  /**
   Creates and returns a `CAAnimation` object that allow the receiver to rotate.

   - parameter duration: The basic duration of the animation, in seconds.
   - parameter beginTime: The begin time of the receiver in relation to its parent object.
   */
  class func rotationAnimationWithDuration(_ duration: TimeInterval, beginTime: CFTimeInterval) -> CAAnimation {
    let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")

    rotationAnimation.fromValue   = 0
    rotationAnimation.toValue     = CGFloat(M_PI * 2)
    rotationAnimation.duration    = duration
    rotationAnimation.repeatCount = HUGE
    rotationAnimation.beginTime   = beginTime

    return rotationAnimation
  }

  class func addMorphinAnimationForPetal(_ petal: CAShapeLayer, pistil: CAShapeLayer, duration: TimeInterval, beginTime: CFTimeInterval, forPetalAt index: UInt, petalCount: Double, constraintInBounds bounds: CGRect) {
    let morphingDuration = duration / 4
    let morphingMod      = petalCount / 4

    let timeOffset     = beginTime + (morphingDuration / morphingMod) * (Double(index).truncatingRemainder(dividingBy: morphingMod))
    let configurations = [
      (layer: petal, values: [0.8, 1, 0.8].map({ pathForPetalAt(index, radiusRatio: $0, petalCount: petalCount, constraintInBounds: bounds) })),
      (layer: pistil, values: [0.2, 0.4, 0.2].map ({ pathForPetalAt(index, radiusRatio: $0, angleOffset: CGFloat(M_PI), petalCount: petalCount, constraintInBounds: bounds) }))
    ]

    for configuration in configurations {
      if configuration.layer.animation(forKey: "morphing") == nil {
        let anim    = PetalAnimation.animationWithDuration(morphingDuration, beginTime: beginTime, timeOffset: timeOffset)
        anim.values = configuration.values

        configuration.layer.add(anim, forKey: "morphing")
      }
    }
  }

  class func pathForPetalAt(_ index: UInt, radiusRatio: CGFloat, angleOffset: CGFloat = 0, petalCount: Double, constraintInBounds bounds: CGRect) -> CGPath {
    let center     = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    let startAngle = angleOffset + CGFloat(M_PI * 2 / petalCount) * CGFloat(index)
    let endAngle   = angleOffset + CGFloat(M_PI * 2 / petalCount) * CGFloat(index + 1)
    let radius     = min(bounds.width / 2, bounds.height / 2) * radiusRatio

    return petalPathAtCenter(center, radius: radius, startAngle: startAngle, endAngle: endAngle)
  }

  class func petalPathAtCenter(_ center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat) -> CGPath {
    let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
    path.addLine(to: center)
    path.close()

    return path.cgPath
  }
}
