//
//  SmallTableCell.swift
//  TapStore
//
//  Created by Paul Hudson on 01/10/2019.
//  Copyright © 2019 Hacking with Swift. All rights reserved.
//

import UIKit

class ArtCell: UICollectionViewCell {
    
    // MARK: - API
    static let reuseIdentifier = "ArtCell"
    
    var vm: ArtCellVM? {
        willSet {
            updateUI(vm: newValue)
        }
    }
    
    // MARK: - Properties
    private let nameLbl = UILabel()
    private let infoImageView = InfoImageView(image: nil)

    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("not supported...")
    }
    
    // MARK: - Overrides
    override func prepareForReuse() {
        super.prepareForReuse()
        
        infoImageView.cancelImageDownload()
    }
    
    // MARK: - Helper
    private func updateUI(vm: ArtCellVM?) {
        guard let vm = vm else { return }
        
        nameLbl.font = vm.textFont
        nameLbl.textColor = vm.textColor
        nameLbl.numberOfLines = vm.numberOfLines
        nameLbl.textAlignment = vm.textAlignment
        nameLbl.sizeToFit()
        
        nameLbl.text = vm.title
        infoImageView.vm = InfoImageVM(imageUrlString: vm.imageHeaderUrlString)
        setLayout(vm: vm, imageView: infoImageView, nameLbl: nameLbl)
    }
    
    private func setLayout(vm: ArtCellVM, imageView: InfoImageView, nameLbl: UILabel) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLbl)
        
        NSLayoutConstraint.activate([
            nameLbl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLbl.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLbl.widthAnchor.constraint(equalToConstant: contentView.frame.size.width - vm.labelWidthPadding),
            
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: vm.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: vm.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: vm.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: vm.bottomAnchor),
        ])
    }
}
