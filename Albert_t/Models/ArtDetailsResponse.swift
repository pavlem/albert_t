import Foundation

struct ArtDetailsResponse: Decodable {
    let count: Int
    let artObjects: [ArtResponse]
}
