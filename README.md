# Petal

[![License](https://cocoapod-badges.herokuapp.com/l/Petal/badge.svg)](http://cocoadocs.org/docsets/FlowingMenu/) [![Supported Platforms](https://cocoapod-badges.herokuapp.com/p/Petal/badge.svg)](http://cocoadocs.org/docsets/FlowingMenu/) [![Version](https://cocoapod-badges.herokuapp.com/v/Petal/badge.svg)](http://cocoadocs.org/docsets/FlowingMenu/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/yannickl/Petal.svg?branch=master)](https://travis-ci.org/yannickl/Petal) [![codecov.io](http://codecov.io/github/yannickl/Petal/coverage.svg?branch=master)](http://codecov.io/github/yannickl/Petal?branch=master)

Petal is a beautiful activity indicator to show that a task is in progress.

<p align="center">
  <img src="http://yannickloriot.com/resources/petal.gif" alt="Petal" width="200"/>
</p>

## Usage

At first, import Petal library:

```swift
import Petal
```

Then just add a `FlowingMenuTransitionManager` object that acts as `transitioningDelegate` of the view controller you want display:

```swift
let flowingMenuTransitionManager = FlowingMenuTransitionManager()

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  let vc                   = segue.destinationViewController
  vc.transitioningDelegate = flowingMenuTransitionManager
}
```

If you want interactive transition you will need to implement the `FlowingMenuDelegate` methods and defines the views which will interact with the gestures:

```swift
var menu: UIViewController?

override func viewDidLoad() {
  super.viewDidLoad()

  // Add the pan screen edge gesture to the current view
  flowingMenuTransitionManager.setInteractivePresentationView(view)

  // Add the delegate to respond to interactive transition events
  flowingMenuTransitionManager.delegate = self
}

override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  let vc                   = segue.destinationViewController
  vc.transitioningDelegate = flowingMenuTransitionManager

  // Add the left pan gesture to the menu
  flowingMenuTransitionManager.setInteractiveDismissView(vc.view)

  // Keep a reference of the current menu
  menu = vc
}

// MARK: - FlowingMenu Delegate Methods

func flowingMenuNeedsPresentMenu(flowingMenu: FlowingMenuTransitionManager) {
  performSegueWithIdentifier("PresentSegueName", sender: self)
}

func flowingMenuNeedsDismissMenu(flowingMenu: FlowingMenuTransitionManager) {
  menu?.performSegueWithIdentifier("DismissSegueName", sender: self)
}
```

Have fun! :)

### For more information...

To go further, take a look at the documentation and the example project.

*Note: All contributions are welcome*

## Installation

#### CocoaPods

Install CocoaPods if not already available:

``` bash
$ [sudo] gem install cocoapods
$ pod setup
```
Go to the directory of your Xcode project, and Create and Edit your Podfile and add _Petal_:

``` bash
$ cd /path/to/MyProject
$ touch Podfile
$ edit Podfile
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

use_frameworks!
pod 'Petal', '~> 1.0.0'
```

Install into your project:

``` bash
$ pod install
```

Open your project in Xcode from the .xcworkspace file (not the usual project file):

``` bash
$ open MyProject.xcworkspace
```

You can now `import Petal` framework into your files.

#### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `Petal` into your Xcode project using Carthage, specify it in your `Cartfile` file:

```ogdl
github "yannickl/Petal" >= 1.0.0
```

#### Manually

[Download](https://github.com/YannickL/Petal/archive/master.zip) the project and copy the `Source` folder into your project to use it in.

## Contact

Yannick Loriot
 - [https://twitter.com/yannickloriot](https://twitter.com/yannickloriot)
 - [contact@yannickloriot.com](mailto:contact@yannickloriot.com)


## License (MIT)

Copyright (c) 2016-present - Yannick Loriot

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
