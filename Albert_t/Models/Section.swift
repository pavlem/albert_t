import Foundation

struct Section: Decodable, Hashable {
    var id: UUID? = UUID()
    let infoArray: [Art]
}
