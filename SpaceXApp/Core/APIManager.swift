//
//  APIManager.swift
//  SpaceXApp
//
//  Created by Srikanth Kyatham on 12/11/24.
//

import Foundation

protocol APIManagerProtocol {
    func fetchMissions(completion: @escaping (Result<[Mission], Error>) -> Void)
}

class APIManager: APIManagerProtocol {
    static let shared = APIManager()

    private init() {}

    func fetchMissions(completion: @escaping (Result<[Mission], Error>) -> Void) {
        let urlString = serverConstants.serverURL
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 0, userInfo: nil)))
                return
            }

            do {
                let missions = try JSONDecoder().decode([Mission].self, from: data)
                completion(.success(missions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
