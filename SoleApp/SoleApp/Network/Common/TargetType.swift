//
//  TargetType.swift
//  SoleApp
//
//  Created by SUN on 2023/08/05.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: RequestParams { get }
}

extension TargetType {

    // URLRequestConvertible 구현
    func asURLRequest() throws -> URLRequest {
        guard let url =  URL(string: baseURL) else { throw AFError.invalidURL(url: baseURL) }
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.headers = headers
        urlRequest.setValue(Utility.load(key: Constant.token), forHTTPHeaderField: "Authorization")

        switch parameters {
        case .query(let query):
            let queryParameter = query?.toParameter()
            let queryItems = queryParameter?.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryItems
            urlRequest.url = components?.url
            
        case .body(let parameter):
            guard let request = parameter else { break }
            let parameterParameter = request.toParameter()
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject:parameterParameter)
            
        case .queryWithBody(let query, let parameter):
            let queryParameter = query?.toParameter()
            let queryItems = queryParameter?.compactMap { URLQueryItem(name: $0.key, value: "\($0.value)") }
            var components = URLComponents(string: url.appendingPathComponent(path).absoluteString)
            components?.queryItems = queryItems
            urlRequest.url = components?.url
            
            guard let request = parameter else { break }
            let parameterParameter = request.toParameter()
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject:parameterParameter)
        }

        return urlRequest
    }
}

enum RequestParams {
    case query(_ parameter: Encodable?)
    case body(_ parameter: Encodable?)
    case queryWithBody(_ query: Encodable?, _ parameter: Encodable?)
}

extension Encodable {
    func toParameter() -> Parameters {
        do {
            guard let data = try? JSONEncoder().encode(self),
                  let parameter = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? Parameters else { return Parameters() }
            return parameter
        } catch(let error) {
            debugPrint(String(format: "[Codable encodeJsonError: %@]", error.localizedDescription))
            return Parameters()
        }
    }
}
