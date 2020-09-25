import ClassKit
import Foundation

struct ContextsRequest: Encodable {
    let contexts: [Context]
}

struct Context: Encodable {
    struct Data: Codable {
        struct ProgressReportingCapabilities: Codable {
            enum Kind: String {
                case duration
                case percent
                case binary
                case quantity
                case score
            }
            
            let details: String
            let kind: String
            
            init(details: String, kind: Kind) {
                self.details = details
                self.kind = kind.rawValue
            }
        }
        
        let displayOrder: Int
        let identifierPath: [String]
        let isAssignable: Bool
        let progressReportingCapabilities: [ProgressReportingCapabilities]
        let summary: String
        let title: String
        let topic: String
        let type: String
    }
    
    struct Metadata: Encodable {
        let keywords: [String]
        let locale: String
        let minimumBundleVersion = "1.0.0"
        let presentableLocales: [String] = ["mul"]
        
        init(keywords: [String], locale: String = "en-us") {
            self.keywords = keywords
            self.locale = locale
        }
    }
    
    let data: Data
    let metadata: Metadata
}
