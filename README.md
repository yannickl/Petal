# Petal ❀

[![Supported Platforms](https://cocoapod-badges.herokuapp.com/p/Petal/badge.svg)](http://cocoadocs.org/docsets/Petal/) [![Version](https://cocoapod-badges.herokuapp.com/v/Petal/badge.svg)](http://cocoadocs.org/docsets/Petal/) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/yannickl/Petal.svg?branch=master)](https://travis-ci.org/yannickl/Petal) [![codecov.io](http://codecov.io/github/yannickl/Petal/coverage.svg?branch=master)](http://codecov.io/github/yannickl/Petal?branch=master) [![codebeat badge](https://codebeat.co/badges/8c8d04c7-60d0-4e5c-aee2-49abff3b9793)](https://codebeat.co/projects/github-com-yannickl-petal)

<p align="center">
  <img src="http://yannickloriot.com/resources/petal-anim.gif" alt="Petal" width="200"/>
</p>

Petal is a beautiful activity indicator to show that a task is in progress.

<p align="center">
    <a href="#usage">Usage</a> • <a href="#installation">Installation</a> • <a href="#contribution">Contribution</a> • <a href="#contact">Contact</a> • <a href="#license-mit">License</a>
</p>

## Usage

At first, import Petal library:

```swift
import Petal
```

Then just create your `Petal`:

```swift
let petal   = Petal()
petal.frame = CGRect(x: 0, y: 0, width: 200, height: 200)

view.addSubview(petal)
```

To update the petal number, the color of each one and the rotation duration use these properties:

```swift
petal.petalCount       = 9
petal.colors           = [.red, .blue, .green]
petal.rotationDuration = 12
```

Like with an activity indicator you can update its behavior when it's stopped:
```swift
petal.hidesWhenStopped = true
```

Have fun! :)

### For more information...

To go further, take a look at the documentation and the example project.

## Installation

### CocoaPods

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
pod 'Petal', '~> 2'
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

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that automates the process of adding frameworks to your Cocoa application.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```

To integrate `Petal` into your Xcode project using Carthage, specify it in your `Cartfile` file:

```ogdl
github "yannickl/Petal" >= 2.0.0
```

### Swift Package Manager
You can use [The Swift Package Manager](https://swift.org/package-manager) to install `Petal` by adding the proper description to your `Package.swift` file:
```swift
import PackageDescription

let package = Package(
    name: "YOUR_PROJECT_NAME",
    dependencies: [
        .Package(url: "https://github.com/yannickl/Petal.git", versions: 2 ..< Version.max)
    ]
)
```

Note that the [Swift Package Manager](https://swift.org/package-manager) is still in early design and development, for more information checkout its [GitHub Page](https://github.com/apple/swift-package-manager).

### Manually

[Download](https://github.com/YannickL/Petal/archive/master.zip) the project and copy the `Source` folder into your project to use it in.

## Contribution

Contributions are welcomed and encouraged *♡*.

## Contact

Yannick Loriot
 - [https://21.co/yannickl/](https://21.co/yannickl/)
 - [https://twitter.com/yannickloriot](https://twitter.com/yannickloriot)

## License (MIT)

Petal is available under the [MIT](https://github.com/yannickl/Petal/blob/master/LICENSE) license.

Copyright (c) 2016-present Yannick Loriot

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
the Software, and to permit persons to whom the Software is furnished to do so,
subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
