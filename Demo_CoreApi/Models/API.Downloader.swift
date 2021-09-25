//
//  API.Downloader.swift
//  Demo_CoreApi
//
//  Created by Khánh Vỹ Đinh on 17/06/2021.
//

import Foundation
extension APIManager.Downloader{
    static func dowloadImage(imageUrl:String,completion:@escaping APICompletion<Data?>){
        API.share().request(urlString: imageUrl, completion: {
            result in
            switch result {
            case .failure(let err):completion(.failure(err))
            case .success(let data):
                completion(.success(data))
            }
        })
    }
}
