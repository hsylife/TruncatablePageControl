 # Truncatable Page Control
A Truncatable Page Control written in Swift 5.

[![Version](https://img.shields.io/cocoapods/v/TruncatablePageControl.svg?style=flat)](http://cocoadocs.org/docsets/TruncatablePageControl) 
[![License](https://img.shields.io/cocoapods/l/TruncatablePageControl.svg?style=flat)](http://cocoadocs.org/docsets/TruncatablePageControl)
[![Platform](https://img.shields.io/cocoapods/p/TruncatablePageControl.svg?style=flat)](http://cocoadocs.org/docsets/TruncatablePageControl)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/hsylife/TruncatablePageControl)

## Features
- Can handle a ton of pages.
- Swift 5.

## Screenshots
|  page 0  |  page 4  |
| ---- | ---- |
|  <img src="https://user-images.githubusercontent.com/11023238/68178729-7142e280-ffd0-11e9-9e62-1e43b946c0f7.png" width="200">  |  <img src="https://user-images.githubusercontent.com/11023238/68178730-7142e280-ffd0-11e9-8c73-78f005bc55fb.png" width="200">  |


## Usage

```swift
pageControl.numberOfPages = 1000
pageControl.currentPage = 0
pageControl.moveToNext() // or, pageControl.moveTo(page: 999)

```

## Required
- Swift 5
- iOS 11+

## License
MIT

## Author
- Yuta Hoshino [Twitter](https://twitter.com/hsylife) [Facebook](https://www.facebook.com/yuta.hoshino)
