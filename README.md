#  Menu Driven Sample

Simple MVVM sample, consuming JSONPlaceholder, from [typicode.com](https://jsonplaceholder.typicode.com).

## Table of Contents

1. Build
2. Layout
3. Discussion
4. Todo


## 1. Build

This project is build with *Xcode Version 11.3 (11C29)*, using *Swift 5.0*, targetting *iOS 11.0*.

No dependencies are required.


## 2. Layout

There are four targets within this project:

1. `CommonUtils` , simple helper extensions, helper classes
2. `SimpleTableViewController` , basic ViewController & ViewModel definitions for an MVVM-UITableView pair. Intended to be reusable.
3. `MenuDrivenSample`, the main focus of this program, demonstrating usage of an MVVM application.
4. `MenuDrivenSampleTest`, tests for `MenuDrivenSample` using XCTest.


Todo: describe types of data from endpoint here:


## 3. Discussion

Todo...?


## 4. Todo

1. Tests could use configuration, arrangement.
	* currently code coverage for `MenuDrivenSample ` is 12.5%.
	
2. Adjust for more customizable reusable cells in `SimpleTableViewController`

3. Add more to this README.

4. Add error-handling & recognition within a State-driven implementation.

5. Is there a more polymorphic way to handle `fetch(api:completion:)` in `APIService.swift`?
