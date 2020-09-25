import ClassKit
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var nav: UINavigationController!
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let gameList = GameListViewController(style: .plain)
        nav = UINavigationController(rootViewController: gameList)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        // Register with ClassKit
        CLSDataStore.shared.delegate = ActivityCreator.shared
        
        // Legacy support: create all contexts on launch so teacher can view available activities
        GameDataSource.shared.all.forEach { game in
            CLSDataStore.shared.mainAppContext.descendant(matchingIdentifierPath: game.identifierPath) { _, _ in }
        }
        
        // Uncomment this to print pretty JSON of activity-hierarchy
//        printJSON()
        
        return true
    }
    
    func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        
        guard
            userActivity.isClassKitDeepLink,
            let identifierPath = userActivity.contextIdentifierPath,
            let identifier = identifierPath.last,
            let game = GameDataSource.shared.game(from: identifier),
            let rootVC = nav.viewControllers.first
            else { return false }
            
        let vc = GameViewController(game: game)
        nav.viewControllers = [rootVC, vc]

        return true
    }
    
    func printJSON() {
        let rootContext = Context(
            data: Context.Data(
                displayOrder: 0,
                identifierPath: [Bundle.main.bundleIdentifier ?? ""],
                isAssignable: false,
                progressReportingCapabilities: [],
                summary: "Fun tapper games for math and writing!",
                title: "EduJam",
                topic: "",
                type: "app"
            ),
            metadata: Context.Metadata(
                keywords: ["math", "writing", "game"]
            )
        )
        
        let gameContexts: [Context] = GameDataSource.shared.all.map { game in
            let order = GameDataSource.shared.all.firstIndex(where: { $0.identifier == game.identifier }) ?? 0
            return game.toCatalogAPIContext(displayOrder: order)
        }
        
        let node = ContextsRequest(contexts: [rootContext] + gameContexts)
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let jsonData = (try? encoder.encode(node)) ?? Data()
        let jsonStr = String(data: jsonData, encoding: .utf8) ?? ""
        print(jsonStr)
    }
}

