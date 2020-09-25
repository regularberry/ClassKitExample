import ClassKit
import Foundation

extension CLSContextType {
    var description: String {
        switch self {
        case .app:
            return "app"
        case .audio:
            return "audio"
        case .book:
            return "book"
        case .challenge:
            return "challenge"
        case .chapter:
            return "chapter"
        case .course:
            return "course"
        case .custom:
            return "custom"
        case .document:
            return "document"
        case .exercise:
            return "exercise"
        case .game:
            return "game"
        case .lesson:
            return "lesson"
        case .level:
            return "level"
        case .none:
            return "none"
        case .page:
            return "page"
        case .quiz:
            return "quiz"
        case .section:
            return "section"
        case .task:
            return "task"
        case .video:
            return "video"
        @unknown default:
            return "none"
        }
    }
}
