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
  @IBOutlet weak var showPetalWhenStoppedButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
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

  @IBAction func toggleShowPetalWhenStoppedAction(sender: AnyObject) {
    petal.hidesWhenStopped = !petal.hidesWhenStopped

    if petal.hidesWhenStopped {
      showPetalWhenStoppedButton.setTitle("Show When Stopped", forState: UIControlState.Normal)
    }
    else {
      showPetalWhenStoppedButton.setTitle("Hide When Stopped", forState: UIControlState.Normal)
    }
  }
}

