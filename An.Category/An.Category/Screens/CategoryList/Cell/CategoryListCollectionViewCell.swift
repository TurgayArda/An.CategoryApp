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
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    
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
    
    var cellViewModel: CategoryListCollectionCellViewModelProtocol?
    
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
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(categoryImage)
        stackView.addArrangedSubview(categoryName)
        
        
        contentView.backgroundColor = .white
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.cornerRadius = 8
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        makeImage()
        makeVStack()
    }
    
    private func propertyUI(item: CategoryList) {
        categoryName.text = cellViewModel?.getName(item: item)
        
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
    private func makeVStack() {
        stackView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalTo(contentView)
        }
    }
    
    private func makeImage() {
        categoryImage.snp.makeConstraints { make in
            make
                .height
                .equalTo(contentView.frame.size.height / 1.5)
            make
                .width
                .equalTo(contentView.frame.size.width)
        }
    }
}
