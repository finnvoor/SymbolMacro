import SwiftDiagnostics
import SwiftSyntax

enum FixIt: Error, CustomStringConvertible {
    case fixIt(String)

    // MARK: Internal

    var description: String {
        switch self {
        case let .fixIt(fixIt): return fixIt
        }
    }
}
