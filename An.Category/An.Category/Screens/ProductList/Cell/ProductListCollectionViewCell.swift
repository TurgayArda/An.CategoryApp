//
//  ProductListCollectionViewCell.swift
//  An.Category
//
//  Created by Arda Sisli on 14.09.2022.
//

import UIKit

class ProductListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Views
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    
    private lazy var  productListImage: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 8
        image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return image
    }()
    
    private lazy var  productListName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var  productListPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var  productListCampaignPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    var cellViewModel: ProductListCollectionCellViewModelProtocol?
    
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
    
    override func prepareForReuse() {
        productListCampaignPrice.isHidden = true
    }
    
    private func configure() {
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(productListImage)
        stackView.addArrangedSubview(productListName)
        stackView.addArrangedSubview(productListPrice)
        stackView.addArrangedSubview(productListCampaignPrice)
        
        
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
    
    private func propertyUI(item: ProductList) {
        productListName.text = cellViewModel?.getName(item: item)
        productListPrice.text = cellViewModel?.getPrice(item: item)
        
        if item.campaignPrice != nil {
            productListCampaignPrice.isHidden = false
            productListCampaignPrice.text = cellViewModel?.getCampaignPrice(item: item)
        }
        
        if let imageName = item.featuredImage?.t {
            if let url = URL(string: imageName){
                productListImage.af.setImage(withURL: url)
            }
        }
    }
    
    func saveModel(item: ProductList) {
        propertyUI(item: item)
    }
}

//MARK: - Constraints

extension  ProductListCollectionViewCell {
    private func makeVStack() {
        stackView.snp.makeConstraints { make in
            make.right.left.top.bottom.equalTo(contentView)
        }
    }
    
    private func makeImage() {
        productListImage.snp.makeConstraints { make in
            make.height.equalTo(contentView.frame.size.height / 1.6)
        }
    }
}

