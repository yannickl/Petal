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
 Use a petal like you use an activity indicator. It means it is useful to show that a task is in progress. A petal appears as a flower with each petals are etheir growing/shinking/rotating or stopped.

 You control when a petal animates by calling the startAnimating and stopAnimating methods.
 */
@IBDesignable public final class Petal: UIView {
  /**
   Prepares the receiver for service after it has been loaded from an Interface Builder archive, or nib file.
   */
  public override func awakeFromNib() {
    super.awakeFromNib()

    setupLayers()
  }

  // MARK: - Setting the Appearence

  /**
  The petal count.
  */
  @IBInspectable public var petalCount: UInt = 15 {
    didSet {
      setupLayers()
    }
  }

  /**
   The colors of the petals. They are displayed sequentially.
   */
  @IBInspectable public var colors = [
    UIColor(red: 72/255, green: 178/255, blue: 197/255, alpha: 1),
    UIColor(red: 112/255, green: 184/255, blue: 197/255, alpha: 1),
    UIColor(red: 56/255, green: 111/255, blue: 121/255, alpha: 1),
    UIColor(red: 197/255, green: 98/255, blue: 53/255, alpha: 1),
    UIColor(red: 121/255, green: 86/255, blue: 56/255, alpha: 1)
    ] {
    didSet {
      setupLayers()
    }
  }

  // MARK: - Managing the Petal Behavior

  /**
  The rotation duration in seconds.
  */
  @IBInspectable public var rotationDuration: Double = 12 {
    didSet {
      setupLayers()
    }
  }

  // MARK: - Managing a Petal

  /**
  Flag to know whether the receiver is animating.

  true if the receiver is animating, otherwise false.
  */
  public fileprivate(set) var animating = false

  /**
   A Boolean value that controls whether the receiver is hidden when the animation is stopped.

   If the value of this property is true (the default), the receiver dismiss its petals when receiver is not animating. If the hidesWhenStopped property is false, the receiver is not hidden when animation stops. You stop an animating progress indicator with the stopAnimating method.
   */
  @IBInspectable public var hidesWhenStopped = true {
    didSet {
      if !animating {
        setupLayers()
      }
    }
  }

  /**
   Starts the animation of the petal.

   When the progress indicator is animated, the petals grow, shrink and rotate to indicate indeterminate progress. The indicator is animated until stopAnimating is called.
   */
  public func startAnimating() {
    guard !animating else {
      return
    }

    animating = true

    if layer.speed == 0 {
      let timeSincePause = CACurrentMediaTime() - layer.timeOffset
      layer.timeOffset   = 0
      layer.beginTime    = timeSincePause

      layer.speed = 1
    }

    if hidesWhenStopped {
      layer.timeOffset = 0
      layer.beginTime  = 0

      let scaleAnimation = PetalAnimation.scaleAnimationFrom(0, to: 1)

      layer.add(scaleAnimation, forKey: "scale")
    }

    prepareAnimations()
  }

  /**
   Stops the animation of the petal.

   Call this method to stop the animation of the petal started with a call to startAnimating. When animating is stopped, the indicator is hidden.
   */
  public func stopAnimating() {
    guard animating else {
      return
    }

    if !hidesWhenStopped {
      let pausedTime   = layer.convertTime(CACurrentMediaTime(), from: nil)
      layer.speed      = 0
      layer.timeOffset = pausedTime
    }
    else {
      let scaleAnimation = PetalAnimation.scaleAnimationFrom(1, to: 0)

      layer.add(scaleAnimation, forKey: "scale")
    }

    animating = false
  }

  // MARK: - Animating Petals

  func prepareAnimations() {
    let beginTime = CACurrentMediaTime()

    if layer.animation(forKey: "rotation") == nil {
      let rotationAnimation = PetalAnimation.rotationAnimationWithDuration(rotationDuration, beginTime: beginTime)

      layer.add(rotationAnimation, forKey: "rotation")
    }

    for i in 0 ..< petalCount {
      PetalAnimation.addMorphinAnimationForPetal(petals[Int(i)], pistil: pistils[Int(i)], duration: rotationDuration, beginTime: beginTime, forPetalAt: i, petalCount: Double(petals.count), constraintInBounds: bounds)
    }
  }

  // MARK: - Creating Petals

  var petals: [CAShapeLayer]  = []
  var pistils: [CAShapeLayer] = []

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

    for i in 0 ..< petalCount {
      setupPetalAndPistal(atIndex: i)
    }

    layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)

    if !hidesWhenStopped {
      layer.removeAnimation(forKey: "scale")
      
      prepareAnimations()
      
      layer.timeOffset = CACurrentMediaTime()
      layer.speed      = 0
    }
  }

  func setupPetalAndPistal(atIndex index: UInt) {
    let color = colors[Int(index) % colors.count].cgColor
  
    let petalLayer         = CAShapeLayer()
    petalLayer.fillColor   = color
    petalLayer.strokeColor = color

    let pistilLayer         = CAShapeLayer()
    pistilLayer.fillColor   = color
    pistilLayer.strokeColor = color

    petals.append(petalLayer)
    pistils.append(pistilLayer)

    layer.addSublayer(petalLayer)
    layer.addSublayer(pistilLayer)
  }
}
