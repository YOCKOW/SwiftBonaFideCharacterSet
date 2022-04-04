// swift-tools-version:5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "BonaFideCharacterSet",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "SwiftBonaFideCharacterSet", type:.dynamic, targets: ["BonaFideCharacterSet"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url:"https://github.com/YOCKOW/SwiftPredicate.git", from: "1.2.1"),
    .package(url:"https://github.com/YOCKOW/SwiftRanges.git", from: "3.1.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(name:"BonaFideCharacterSet", dependencies: ["SwiftPredicate", "SwiftRanges"]),
    .testTarget(name: "BonaFideCharacterSetTests", dependencies: ["BonaFideCharacterSet"]),
  ]
)


import Foundation
if ProcessInfo.processInfo.environment["YOCKOW_USE_LOCAL_PACKAGES"] != nil {
  func localPath(with url: String) -> String {
    guard let url = URL(string: url) else { fatalError("Unexpected URL.") }
    let dirName = url.deletingPathExtension().lastPathComponent
    return "../\(dirName)"
  }
  package.dependencies = package.dependencies.map {
    guard case .sourceControl(_, let location, _) = $0.kind else { fatalError("Unexpected dependency.") }
    return .package(path: localPath(with: location))
  }
}
