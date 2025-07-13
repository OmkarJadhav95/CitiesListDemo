//
//  NetworkService.swift
//  CitiesListDemo
//
//  Created by Omkar Jadhav on 08/05/24.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    private init() {}

    /*
    // Network call to fetch citis list using completition handler
    func fetchCities(completion: @escaping (Result<[CityData], Error>) -> ()) {
        DispatchQueue.global(qos: .background).async {
            guard let url = URL(string: "https://api.example.com/cities") else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
                    return
                }
                
                do {
                    let cities = try JSONDecoder().decode([CityData].self, from: data)
                    completion(.success(cities))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }
    */
    
    // Network call to fetch citis list using async await
    func fetchCities() async throws -> Data {
        //create the url
        guard let url = URL(string: "https://api.example.com/cities") else {
            throw NSError(domain: "Invalid URL", code: 0, userInfo: nil)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
