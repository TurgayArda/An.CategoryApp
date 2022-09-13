//
//  CategoryListCollectionViewCell.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import UIKit
import AlamofireImage

class CategoryListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    private lazy var categoryImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        return image
    }()
    
    private lazy var categoryName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    //var cellViewModel: MovieListCollectionCellViewModelProtocol?
    
    enum Identifier: String {
        case path = "Cell"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryName)
        
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8
        
        makeImage()
        makeName()
    }
    
    private func propertyUI(item: CategoryList) {
        categoryName.text = item.name
        
        if let imageName = item.icon {
            if let url = URL(string: imageName){
                categoryImage.af.setImage(withURL: url)
            }
        }
    }
    
    
    func saveModel(item: CategoryList) {
        propertyUI(item: item)
    }
}

//MARK: - Constraints

extension CategoryListCollectionViewCell {
    private func makeImage() {
        categoryImage.snp.makeConstraints { make in
            make
                .left
                .equalTo(contentView)
                .offset(8)
            make
                .centerY
                .equalTo(contentView.snp.centerY)
            make
                .height
                .equalTo(contentView.frame.size.height / 2)
            make
                .width
                .equalTo(contentView.frame.size.width )
        }
    }
    
    private func makeName() {
        categoryName.snp.makeConstraints { make in
            make
                .top
                .equalTo(categoryImage.snp.bottom)
                .offset(16)
            make
                .left
                .equalTo(contentView)
                .offset(16)
            make
                .right
                .equalTo(contentView.snp.right)
                .offset(-16)
        }
    }
}
