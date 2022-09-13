//
//  CategoryListBuilder.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import Foundation

final class CategoryListBuilder {
    static func make() -> CategoryListVC {
        let view = CategoryListVC()
        //view.movieListViewModel = MovieListViewModel(httpClient: HttpClient())
        return view
    }
}
