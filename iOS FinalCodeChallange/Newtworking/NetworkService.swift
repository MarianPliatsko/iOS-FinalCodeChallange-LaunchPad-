//
//  NetworkService.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation

enum NetworkError: Error {
    case urlIsMissing
    case notFound
    case badResponse
    case unknown
}

protocol NetworkService {
    func request(urlRequest: URLRequest, callback: @escaping (Result<Data, Error>) -> Void)
}

final class StubNetworkService: NetworkService {
    func request(urlRequest: URLRequest, callback: @escaping (Result<Data, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else {
                callback(.failure(NetworkError.unknown))
                return
            }
            guard let url = urlRequest.url else {
                callback(.failure(NetworkError.urlIsMissing))
                return
            }
            if url.absoluteString.hasSuffix("profiles/me") {
                if let data = self.profilesResponse().data(using: .utf8) {
                    callback(.success(data))
                    return
                } else {
                    callback(.failure(NetworkError.badResponse))
                    return
                }
            }
            if url.absoluteString.hasSuffix("profiles/update") {
                if let data = self.profilesResponse().data(using: .utf8) {
                    callback(.success(data))
                    return
                } else {
                    callback(.failure(NetworkError.badResponse))
                    return
                }
            }
            
            if url.absoluteString.hasSuffix("profiles/password/change") {
                if let data = self.passwordResponse().data(using: .utf8) {
                    callback(.success(data))
                    return
                } else {
                    callback(.failure(NetworkError.badResponse))
                    return
                }
            }
            callback(.failure(NetworkError.notFound))
        }
    }
    
    private func profilesResponse() -> String {
        return """
{
    "msg": "Success",
    "msg_code": 200,
    "data":{
        "firstName": "Marian",
        "userName": "Marian Pliatsko",
        "lastName": "Pliatsko"
    }
}
"""
    }
    
    private func passwordResponse() -> String {
        return """
{
    "msg": "Success",
    "msg_code": 200
}
"""
    }
}
