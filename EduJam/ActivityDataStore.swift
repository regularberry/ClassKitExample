import ClassKit

class ActivityCreator: NSObject, CLSDataStoreDelegate {
    static let shared = ActivityCreator()
    
    func createContext(forIdentifier identifier: String, parentContext: CLSContext, parentIdentifierPath: [String]) -> CLSContext? {
        guard let game = GameDataSource.shared.game(from: identifier) else { return nil }
        let context = CLSContext(type: .game, identifier: game.identifier, title: game.title)
        context.topic = game.topic
        return context
    }
}
