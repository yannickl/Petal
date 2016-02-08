//
//  ViewController.swift
//  Petal
//
//  Created by Yannick LORIOT on 07/02/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var petal: Petal!
  @IBOutlet weak var startButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()

    petal.colors = [UIColor.redColor(), UIColor.greenColor(), UIColor.blueColor()]
  }

  @IBAction func startAction(sender: AnyObject) {
    if !petal.animating {
      startButton.setTitle("Stop", forState: UIControlState.Normal)

      petal.startAnimating()
    }
    else {
      startButton.setTitle("Start", forState: UIControlState.Normal)
      
      petal.stopAnimating()
    }
  }
}

