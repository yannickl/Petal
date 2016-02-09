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
final class PetalAnimation: CAKeyframeAnimation {
  /**
   Creates and returns a `CAKeyframeAnimation` object with pre-configured properties.

   - parameter duration: The basic duration of the animation, in seconds.
   - parameter beginTime: The begin time of the receiver in relation to its parent object.
   - parameter timeOffset: Additional time offset in active local time.
   */
  class func animationWithDuration(duration: CFTimeInterval, beginTime: CFTimeInterval, timeOffset: CFTimeInterval) -> Self {
    let anim = self.init(keyPath: "path")

    anim.keyTimes            = [0, 0.5, 1]
    anim.repeatCount         = HUGE
    anim.duration            = duration
    anim.beginTime           = beginTime
    anim.timeOffset          = timeOffset
    anim.fillMode            = kCAFillModeForwards
    anim.removedOnCompletion = false

    return anim
  }
}
