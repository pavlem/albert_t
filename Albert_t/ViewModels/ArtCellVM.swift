import UIKit

struct ArtCellVM {

    let title: String
    let longTitle: String
    var imageUrlString: String
    var imageHeaderUrlString: String

    let textFont = UIFont.systemFont(ofSize: 22, weight: .heavy)
    let textColor = UIColor(red: 242/255.0, green: 215/255.0, blue: 102/255.0, alpha: 1)
    let numberOfLines = 0
    let backgroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1)
    let spacing = CGFloat(10)
    let labelWidthPadding = CGFloat(30)
    let leadingAnchor = CGFloat(10)
    let trailingAnchor = CGFloat(-10)
    let topAnchor = CGFloat(10)
    let bottomAnchor = CGFloat(0)
    let textAlignment = NSTextAlignment.center
}

extension ArtCellVM {
    init(art: Art) {
        title = art.title
        longTitle = art.longTitle
        imageUrlString = art.imageUrl
        imageHeaderUrlString = art.headerImageUrl
    }
    
    var placeHolderImage: UIImage? {
        return UIImage(named: "demoImg")
    }
}
