//
//  Layer.swift
//  Petal
//
//  Created by Yannick LORIOT on 08/02/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import UIKit
import QuartzCore

final class PetalAnimation: CAKeyframeAnimation {
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
