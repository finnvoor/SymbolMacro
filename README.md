# SymbolMacro
Compile-time checked SF Symbol names using Swift Macros

```swift
let package = Package(
    name: "SymbolMacro",
    platforms: [.iOS(.v13), .macOS(.v11), .tvOS(.v13), .watchOS(.v6), .macCatalyst(.v13)],
)
```

![Example](https://github.com/Finnvoor/SymbolMacro/assets/8284016/a38013ce-8d09-439c-97c5-0b4c79ce0471)

### #symbol
```swift
let symbolName = #symbol("figure.walk")
// Expands to:
let symbolName = "figure.walk"
```

```swift
let symbolName = #symbol("figure.eating.beans")
// Error: 1:18 invalid symbol name
```

### #symbolImage
```swift
let symbol = #symbolImage("figure.walk")
// Expands to:
let symbol = Image("figure.walk")
```

```swift
let symbol = #symbolImage("figure.eating.beans")
// Expands to:
// Error: 1:14 invalid symbol name
```

### Limitations
[Symbol availability is based on the OS version of the device compiling an app, not the target deployment version of the app.](https://github.com/Finnvoor/SymbolMacro/issues/1)

### Alternatives
SF Symbols can be accessed using hardcoded enum cases using:
- https://github.com/SFSafeSymbols/SFSafeSymbols
- https://github.com/sparrowcode/SafeSFSymbols

These give inline autocomplete of symbols, whereas `SymbolMacro` is used with string literals that can be searched using the Xcode symbol library (⌘⇧L). `SymbolMacro` avoids the requirement of needing to wait for a 3rd-party library to update when new symbols are released.
