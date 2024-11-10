//
//  NetworkLayer.swift
//  MVP+Router
//
//  Created by NikitaKorniuk   on 11.10.24.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
}

protocol NetworkServiceProtocol {
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void)
    func fetchProductDetails(id: Int, completion: @escaping (Result<Product, NetworkError>) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchProducts(completion: @escaping (Result<[Product], NetworkError>) -> Void) {
        guard let url = createURL(for: .getProducts) else {
            completion(.failure(.noData))
            return
        }
        let request = URLRequest(url: url)
        performRequest(with: request, completion: completion)
    }
    
    func fetchProductDetails(id: Int, completion: @escaping (Result<Product, NetworkError>) -> Void) {
        let endPoint = EndPoint.getProductsDetails(id: id)
        guard let url = createURL(for: endPoint) else {
            completion(.failure(.noData))
            return
        }
        let request = URLRequest(url: url)
        performRequest(with: request, completion: completion)
    }
    
    private func performRequest<T: Decodable>(with request: URLRequest, completion: @escaping (Result<T, NetworkError>) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.transportError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 || httpResponse.statusCode == 201,
                  let data = data else {
                completion(.failure(.serverError(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 500)))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch let decodingError as DecodingError {
                completion(.failure(.decodingError(decodingError)))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }.resume()
    }
    
    private func createURL(for endPoint: EndPoint) -> URL? {
        var components = URLComponents()
        components.scheme = API.scheme
        components.host = API.host
        components.path = endPoint.path
        return components.url
    }
}
