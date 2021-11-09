//
//  HTTPClient.swift
//  CryptoViewer
//
//  Created by Errol on 03/11/21.
//

import Foundation

final class HTTPClient: NetworkService {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func performRequest<ExpectedData: Decodable>(_ request: URLRequest, expectedData: ExpectedData.Type, completion: @escaping (Result<ExpectedData, NetworkError>) -> Void) {
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(.connectivity))
                return
            }
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200 else {
                      completion(.failure(.invalidResponseCode))
                      return
                  }
            do {
                let decodedData = try JSONDecoder().decode(ExpectedData.self, from: data)
                completion(.success(decodedData))
            } catch {
                print(error)
                completion(.failure(.invalidData))
            }
        }.resume()
    }
}
