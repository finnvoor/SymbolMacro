import Foundation
import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

// MARK: - SymbolMacroPlugin

@main struct SymbolMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        SymbolMacro.self,
        SymbolImageMacro.self
    ]
}

// MARK: - SymbolMacro

public struct SymbolMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in _: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let expression = node.argumentList.first?.expression,
              let segments = expression.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case let .stringSegment(stringSegment)? = segments.first
        else {
            throw FixIt.fixIt("#symbol requires a static string literal")
        }
        #if canImport(UIKit)
        guard UIImage(systemName: stringSegment.content.text) != nil else {
            throw FixIt.fixIt("invalid symbol name")
        }
        #elseif canImport(AppKit)
        guard NSImage(systemSymbolName: stringSegment.content.text, accessibilityDescription: nil) != nil else {
            throw FixIt.fixIt("invalid symbol name")
        }
        #endif
        return "\(expression)"
    }
}

// MARK: - SymbolImageMacro

public struct SymbolImageMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in _: some MacroExpansionContext
    ) throws -> ExprSyntax {
        guard let expression = node.argumentList.first?.expression,
              let segments = expression.as(StringLiteralExprSyntax.self)?.segments,
              segments.count == 1,
              case let .stringSegment(stringSegment)? = segments.first
        else {
            throw FixIt.fixIt("#symbolImage requires a static string literal")
        }
        #if canImport(UIKit)
        guard UIImage(systemName: stringSegment.content.text) != nil else {
            throw FixIt.fixIt("invalid symbol name")
        }
        #elseif canImport(AppKit)
        guard NSImage(systemSymbolName: stringSegment.content.text, accessibilityDescription: nil) != nil else {
            throw FixIt.fixIt("invalid symbol name")
        }
        #endif
        return "Image(systemName: \(expression))"
    }
}
