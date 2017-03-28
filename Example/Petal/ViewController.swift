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

  @IBAction func startAction(_ sender: AnyObject) {
    if !petal.isAnimating {
      startButton.setTitle("Stop", for: .normal)

      petal.startAnimating()
    }
    else {
      startButton.setTitle("Start", for: .normal)
      
      petal.stopAnimating()
    }
  }

  @IBAction func toggleShowPetalWhenStoppedAction(_ sender: AnyObject) {
    petal.hidesWhenStopped = !petal.hidesWhenStopped

    if petal.hidesWhenStopped {
      showPetalWhenStoppedButton.setTitle("Show When Stopped", for: .normal)
    }
    else {
      showPetalWhenStoppedButton.setTitle("Hide When Stopped", for: .normal)
    }
  }
}

