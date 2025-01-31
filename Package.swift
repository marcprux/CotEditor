// swift-tools-version:5.4
import PackageDescription

let package = Package(
    name: "SyntaxEditor",
    defaultLocalization: "en",
    platforms: [ .macOS(.v11), .iOS(.v14) ],
    products: [ 
        .library(name: "SyntaxEditor", targets: ["SyntaxEditor"]),
        .executable(name: "SyntaxEditorDemo", targets: ["SyntaxEditorDemo"]),
    ],
    dependencies: [
        .package(name: "Yams", url: "https://github.com/jpsim/Yams.git", from: "4.0.6"),
        .package(name: "ColorCode", url: "https://github.com/1024jp/WFColorCode.git", from: "2.7.0"),
    ],
    targets: [
        .target(name: "SyntaxEditor", dependencies: [
            .target(name: "CotEditor", condition: .when(platforms: [.macOS]))
        ]),
        .target(name: "CotEditor", dependencies: [
            .product(name: "Yams", package: "Yams", condition: .when(platforms: [.macOS])),
            .product(name: "ColorCode", package: "ColorCode", condition: .when(platforms: [.macOS])),
        ],
        exclude: [
        ],
        resources: [
            .process("Resources"),
            .copy("Themes"),
            .copy("Syntaxes"),
        ],
        linkerSettings: [
            .linkedFramework("AppKit"),
        ]),
        .executableTarget(
            name: "SyntaxEditorDemo",
            dependencies: [ "SyntaxEditor" ])

    ]
)

