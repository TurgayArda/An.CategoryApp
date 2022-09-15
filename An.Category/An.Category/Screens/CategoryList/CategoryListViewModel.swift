//
//  CategoryListViewModel.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import Foundation
import Alamofire

final class CategoryListViewModel: CategoryListViewModelProtocol {
    var delegate: CategoryListViewModelDelegate?
    var service: HttpClientProtocol?
    
    init(service: HttpClientProtocol) {
        self.service = service
    }
}

//MARK: - load()

extension CategoryListViewModel {
    func load() {
        delegate?.handleOutPut(.title(CategoryListConstant.CategoryListConstant.title.rawValue))
        service?.fetch(url: CategoryListConstant.CategoryListURL.categoryListPathURL(),
                       completion: { [delegate] (result: Result<CategoryListResult, Error>) in
            switch result {
            case .success(let categoryItem):
                guard let categoryItemTwo =  categoryItem.data else { return }
                delegate?.handleOutPut(.showCategoryList(categoryItemTwo))
            case .failure(let error):
                delegate?.handleOutPut(.showError(error.localizedDescription))
            }
        })
    }
}

