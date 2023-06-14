import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import SymbolMacroPlugin
import XCTest

let testMacros: [String: Macro.Type] = [
    "symbol": SymbolMacro.self,
    "symbolImage": SymbolImageMacro.self
]

// MARK: - SymbolMacroTests

final class SymbolMacroTests: XCTestCase {
    func testValidSymbol() {
        assertMacroExpansion(
            """
            let systemSymbolName = #symbol("figure.run")
            """,
            expandedSource: """
            let systemSymbolName = "figure.run"
            """,
            macros: testMacros
        )
    }

    func testInvalidSymbol() {
        assertMacroExpansion(
            #"""
            let systemSymbolName = #symbol("figure.beans")
            """#,
            expandedSource: #"""
            let systemSymbolName = #symbol("figure.beans")
            """#,
            diagnostics: [.init(message: "invalid symbol name", line: 1, column: 24)],
            macros: testMacros
        )
    }

    func testValidSymbolImage() {
        assertMacroExpansion(
            """
            let systemSymbolName = #symbolImage("figure.run")
            """,
            expandedSource: """
            let systemSymbolName = Image(systemName: "figure.run")
            """,
            macros: testMacros
        )
    }

    func testInvalidSymbolImage() {
        assertMacroExpansion(
            """
            let systemSymbolImage = #symbolImage("figure.beans")
            """,
            expandedSource: """
            let systemSymbolImage = #symbolImage("figure.beans")
            """,
            diagnostics: [.init(message: "invalid symbol name", line: 1, column: 25)],
            macros: testMacros
        )
    }
}
