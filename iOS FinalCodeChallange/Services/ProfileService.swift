//
//  ProfileService.swift
//  iOS FinalCodeChallange
//
//  Created by mac on 2023-04-18.
//

import Foundation

private enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol ProfileService {
    func fetchMineProfile(callback: @escaping (Result<Profile, Error>) -> Void)
    func updateProfile(user: User, callback: @escaping (Result<Profile, Error>) -> Void)
    func updatePassword(password: String, callback: @escaping (Result<Password, Error>) -> Void)
}

final class ProfileServiceImpl: ProfileService {
    
    private let networkService: NetworkService
    
    private let baseURL = URL(string: "https://yourUrl.com/")!
    
    init(networkService: NetworkService = StubNetworkService()) {
        self.networkService = networkService
    }
    
    func fetchMineProfile(callback: @escaping (Result<Profile, Error>) -> Void) {
        let request = makeRequest(for: "profiles/me", method: .get)
        networkService.request(urlRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    callback(.success(try JSONDecoder().decode(Profile.self, from: data)))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func updateProfile(user: User, callback: @escaping (Result<Profile, Error>) -> Void) {
        let request = makeRequest(for: "profiles/update", method: .post)
        networkService.request(urlRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    callback(.success(try JSONDecoder().decode(Profile.self, from: data)))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    func updatePassword(password: String, callback: @escaping (Result<Password, Error>) -> Void) {
        let request = makeRequest(for: "profiles/password/change", method: .post)
        networkService.request(urlRequest: request) { result in
            switch result {
            case .success(let data):
                do {
                    callback(.success(try JSONDecoder().decode(Password.self, from: data)))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error):
                callback(.failure(error))
            }
        }
    }
    
    private func makeRequest(for endpoint: String, method: HTTPMethod) -> URLRequest {
        var request = URLRequest(url: baseURL.appendingPathComponent(endpoint))
        request.httpMethod = method.rawValue
        request.addValue("Fake token", forHTTPHeaderField: "Authorization")
        return request
    }
}
