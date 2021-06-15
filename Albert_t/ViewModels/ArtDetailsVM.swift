import UIKit

struct ArtDetailsVM {
    let title: String
    let longTitle: String
    let textColor: UIColor
    let backgroundColor: UIColor
    var imageUrl: String
    var imageHeaderUrl: String
    
    let textFont = UIFont.systemFont(ofSize: 22, weight: .heavy)
    let textPadding = CGFloat(20)
    let spacing = CGFloat(20)
}

extension ArtDetailsVM {
    init(artCellVM: ArtCellVM) {
        title = artCellVM.title
        longTitle = artCellVM.longTitle
        textColor = artCellVM.textColor
        backgroundColor = artCellVM.backgroundColor
        imageUrl = artCellVM.imageUrlString
        imageHeaderUrl = artCellVM.imageHeaderUrlString
    }
}
