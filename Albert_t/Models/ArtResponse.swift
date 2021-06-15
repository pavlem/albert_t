import Foundation

struct ArtResponse: Decodable {
    let id: String
    let objectNumber: String
    let title: String
    let longTitle: String
    let webImage: ArtResponseWebImage
    let headerImage: ArtResponseHeaderImage
}

struct ArtResponseWebImage: Decodable {
    let url: String
}
struct ArtResponseHeaderImage: Decodable {
    let url: String
}

