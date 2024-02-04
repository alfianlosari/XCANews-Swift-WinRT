import Foundation

enum Category: String, CaseIterable, Codable {
    case general, business, technology, entertainment, sports, science, health

    var text: String { self.rawValue.capitalized }
    var glyph: String {
        switch self {
            case .general: return "\u{E80F}" 
            case .business: return "\u{E821}" 
            case .technology: return "\u{EBC6}"
            case .entertainment: return "\u{E8B2}"
            case .science: return "\u{E95F}"
            case .health: return "\u{E95E}"
            case .sports: return "\u{E716}"
        }
    }

    var sortIndex: Int {
        Self.allCases.firstIndex(of: self) ?? 0
    }
}