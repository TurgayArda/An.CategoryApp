//
//  Service.swift
//  An.Category
//
//  Created by Arda Sisli on 13.09.2022.
//

import Foundation
import Alamofire

enum HttpError: Error {
    case errorDecodingData
}


protocol HttpClientProtocol {
    func fetch<T: Codable>(url: String,
                           completion: @escaping (Result<T, Error>) -> Void
    )
}

class HttpClient: HttpClientProtocol {
    let headers: HTTPHeaders = [  "Api-Key": "xXspnfUxPzOGKNu90bFAjlOTnMLpN8veiixvEFXUw9I=",
                                  "Alias-Key": "AtS1aPFxlIdVLth6ee2SEETlRxk=",
                                  "Accept-Language": "en-US,en;q=0.5"
                                  ] 
    
    func fetch<T: Codable>(url: String,
                           completion: @escaping (Result<T, Error>) -> Void) {

        AF.request(url, method: .get, headers: headers).validate().responseDecodable(of: T.self) { categoryItem in
            guard let data = categoryItem.value else {
                return completion(.failure(HttpError.errorDecodingData))
            }
            completion(.success(data))
        }
    }
}
