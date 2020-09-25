import Foundation
import SwiftJWT

// Your ClassKit Catalog Key ID
let header = Header(kid: "<insert key id>")

// iss = your Developer Team ID
// iat - start time when the JWT is valid
// exp - when the JWT expires
let claims = ClaimsStandardJWT(iss: "<insert team id>", exp: Date(timeIntervalSinceNow: 3600), iat: Date())

var jwt = JWT(header: header, claims: claims)

let privateKeyPath = URL(fileURLWithPath: "/Users/path/to/your-key.p8")

do {
    let privateKey: Data = try Data(contentsOf: privateKeyPath, options: .alwaysMapped)
    let signer = JWTSigner.es256(privateKey: privateKey)
    let signedJWT = try jwt.sign(using: signer)
    print(signedJWT)
} catch {
    print(error)
}
