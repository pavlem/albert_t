import Foundation

struct Art: Decodable, Hashable {
    let id: String
    let title: String
    let longTitle: String
    let imageUrl: String
    let headerImageUrl: String
}

extension Art {
    init(artResponse: ArtResponse) {
        self.id = artResponse.id
        self.title = artResponse.title
        self.longTitle = artResponse.longTitle
        self.imageUrl = artResponse.webImage.url
        self.headerImageUrl = artResponse.headerImage.url
    }
}
