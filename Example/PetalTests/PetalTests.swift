//
//  PetalTests.swift
//  PetalTests
//
//  Created by Yannick LORIOT on 07/02/16.
//  Copyright © 2016 Yannick Loriot. All rights reserved.
//

import XCTest

class PetalTests: XCTestCase {
  func testPetalCount() {
    let petalView = Petal()

    petalView.petalCount = 12

    XCTAssertEqual(petalView.petals.count, 12)
    XCTAssertEqual(petalView.pistils.count, 12)

    petalView.petalCount = 23

    XCTAssertEqual(petalView.petals.count, 23)
    XCTAssertEqual(petalView.pistils.count, 23)

    petalView.petalCount = 0

    XCTAssertEqual(petalView.petals.count, 0)
    XCTAssertEqual(petalView.pistils.count, 0)
  }

  func testPetalColors() {
    let petalView = Petal()

    petalView.petalCount = 12
    petalView.colors     = [.redColor(), .blueColor()]

    for (i, petal) in petalView.petals.enumerate() {
      XCTAssertTrue(CGColorEqualToColor(petal.fillColor, petalView.colors[i % petalView.colors.count].CGColor))
    }

    petalView.colors = [.redColor(), .blueColor(), .greenColor()]

    for (i, petal) in petalView.petals.enumerate() {
      XCTAssertTrue(CGColorEqualToColor(petal.fillColor, petalView.colors[i % petalView.colors.count].CGColor))
    }
  }
}
