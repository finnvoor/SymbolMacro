import Foundation
import SwiftUI

// Creates a string from a static string SF symbol name. The symbol name is checked to
// be valid during compile time.
@freestanding(expression) public macro symbol(_ stringLiteral: String) -> String = #externalMacro(
    module: "SymbolMacroPlugin",
    type: "SymbolMacro"
)
// Creates a SwiftUI Image from a static string SF symbol name. The symbol name is checked to
// be valid during compile time.
@freestanding(expression) public macro symbolImage(_ stringLiteral: String) -> Image = #externalMacro(
    module: "SymbolMacroPlugin",
    type: "SymbolImageMacro"
)
