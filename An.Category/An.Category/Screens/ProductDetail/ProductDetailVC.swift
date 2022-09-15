//
//  ProductDetailVC.swift
//  An.Category
//
//  Created by Arda Sisli on 15.09.2022.
//

import UIKit

class ProductDetailVC: UIViewController {
    
    //MARK: Views
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        scroll.backgroundColor = .white
        scroll.contentSize = CGSize(width: 0 , height: view.frame.height)
        return scroll
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .lastBaseline
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        return stackView
    }()
    
    private var productDetailImage: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private var productDetailName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 22)
        label.textColor = .black
        return label
    }()
    
    private lazy var productDetailPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var productDetailCampaignPrice: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Description:"
        label.isHidden = true
        return label
    }()
    
    private lazy var productDetailDescription: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var productStock: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var addBasketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Basket", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        return button
    }()
    
    //MARK: - Properties
    
    private var productDetailItem: ProductDetail?
    
    var productDetailViewModel: ProductDetailViewModelProtocol?
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDelegate()
        productDetailViewModel?.loadProductDetail()
    }
    
    //MARK: - Private Func
    
    private func initDelegate() {
        productDetailViewModel?.delegate = self
        
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addArrangedSubview(productDetailImage)
        stackView.addArrangedSubview(productDetailName)
        stackView.addArrangedSubview(productDetailPrice)
        stackView.addArrangedSubview(productDetailCampaignPrice)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(productDetailDescription)
        stackView.addArrangedSubview(productStock)
        stackView.addArrangedSubview(addBasketButton)
        
        configureConstraints()
    }
    
    private func  configureConstraints() {
        makeScroll()
        makeStack()
        makeImage()
        makeAddBasketButton()
    }
    
    private func propertyUI(item: ProductDetail) {
        productDetailName.text = productDetailViewModel?.getDetailName()
        productDetailPrice.text = productDetailViewModel?.getDetailPrice()
        
        if item.campaignPrice != nil {
            productDetailCampaignPrice.isHidden = false
            productDetailCampaignPrice.text = productDetailViewModel?.getDetailCampaignPrice()
        }
        
        if item.dataDescription != nil {
            productDetailDescription.isHidden = false
            descriptionLabel.isHidden = false
            guard let description = item.dataDescription else { return }
            productDetailDescription.text = description.html2String
        }
        
        if item.stock == 0 {
            productStock.isHidden = false
            productStock.text = "Out of stock"
        }
        
        
        if let imageName = item.featuredImage?.t {
            if let url = URL(string: imageName){
                productDetailImage.af.setImage(withURL: url)
            }
        }
    }
}

//MARK: HTML to String 

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

//MARK: ProductDetailViewModelDelegate

extension ProductDetailVC: ProductDetailViewModelDelegate {
    func handleOutPut(_ output: ProductDetailViewModelOutPut) {
        switch output {
        case .showProductDetail(let productDetail):
            self.productDetailItem = productDetail
            propertyUI(item: productDetail)
        case .showError(let error):
            print(error)
        case .title(let title):
            self.title = title
        }
    }
}

//MARK: Constraints

extension ProductDetailVC {
    private func makeScroll() {
        scrollView.snp.makeConstraints { make in
            make.top.bottom.equalTo(view)
            make.right.equalTo(-8)
            make.left.equalTo(8)
            make.width.equalTo(view.frame.size.width)
        }
    }
    
    private func makeStack() {
        stackView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalTo(scrollView)
            make.width.equalTo(scrollView.snp.width)
        }
    }
    
    private func makeImage() {
        productDetailImage.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(view.frame.size.height / 3)
            make.width.equalTo(view.snp.width)
        }
    }
    
    private func makeAddBasketButton() {
        addBasketButton.snp.makeConstraints { make in
            make.height.equalTo(view.frame.size.height / 13)
            make.width.equalTo(view.frame.size.width / 2)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}
