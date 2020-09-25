import ClassKit
import Foundation
import UIKit

struct Game {
    let backgroundColor: UIColor
    let contextType: CLSContextType = .game
    let identifier: String
    var identifierPath: [String] { [identifier] }
    let keywords: [String]
    let summary: String
    let symbolGenerator: () -> String
    let title: String
    let topic: CLSContextTopic
    
    func startActivity() {
        CLSDataStore.shared.mainAppContext.descendant(matchingIdentifierPath: identifierPath) { context, _ in

            context?.becomeActive()
            
            if let activity = context?.currentActivity {
                activity.start()
            } else {
                context?.createNewActivity().start()
            }
            
            CLSDataStore.shared.save()
        }
    }
    
    func endActivity() {
        CLSDataStore.shared.mainAppContext.descendant(matchingIdentifierPath: identifierPath) { context, _ in
            guard let activity = context?.currentActivity else { return }

            activity.stop()
            context?.resignActive()
            
            CLSDataStore.shared.save()
        }
    }
    
    func setScore(_ score: Int) {
        let quantity = CLSQuantityItem(identifier: "Score", title: "Score")
        quantity.quantity = Double(score)
        
        CLSDataStore.shared.mainAppContext.descendant(matchingIdentifierPath: identifierPath) { context, _ in
            guard let activity = context?.currentActivity else { return }
            activity.primaryActivityItem = quantity
            CLSDataStore.shared.save()
        }
    }
    
    func toCatalogAPIContext(displayOrder: Int) -> Context {
        return Context(
            data: Context.Data(
                displayOrder: displayOrder,
                identifierPath: [Bundle.main.bundleIdentifier ?? ""] + identifierPath,
                isAssignable: true,
                progressReportingCapabilities: [ .init(details: "Score", kind: .quantity) ],
                summary: summary,
                title: title,
                topic: topic.rawValue,
                type: contextType.description
            ),
            metadata: Context.Metadata(
                keywords: keywords
            )
        )
    }
}
