//
//  APIClient.swift
//  Intermedia-Marvel
//
//  Created by Nicolas Famularo on 23/02/2024.
//

import UIKit
import Combine

struct APIClient {
    
    static var environment: Environment = .dev

    static var BASE_URL: String {
        return environment.rawValue
    }

    enum Environment: String {
        case dev    = "https://gateway.marvel.com/v1/public/"
        case prod   = ""
    }
    
}

protocol APIRequest {
    associatedtype ResponseType: Codable
    
    var method      : HTTPMethod        { get }
    var path        : String            { get }
    var headers     : [String : String] { get }
    var parameters  : [String : Any?]?  { get }
    var log         : Bool              { get }
}

extension APIRequest {
    var method        : HTTPMethod          { return .get }
    var parameters    : [String: Any?]?     { return nil }
    var headers       : [String: String]    { return [:] }
    var log           : Bool                { return true }
    
    func dispatch() -> AnyPublisher<ResponseType, Error> {
        
        guard let url = URL(string: path.contains("http") ? path : APIClient.BASE_URL + path) else {
            fatalError("Could not get url")
        }
        
        let params = parameters?.normalized ?? [:]
        
        var urlRequest: URLRequest
        
        if method == .get {
            var components = URLComponents(string: APIClient.BASE_URL + path)!
            if path.contains("http") {
                components = URLComponents(string: path)!
            }
            
            components.queryItems = params.compactMap { (key, value) in
                URLQueryItem(name: key, value: "\(value ?? "")")
            }
            
            urlRequest = URLRequest(url: components.url!)
            
        } else {
            urlRequest = URLRequest(url: url)
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        urlRequest.httpMethod = method.rawValue
        
        var headers = self.headers
        headers["Content-Type"] = headers["Content-Type"] ?? "application/json"
        
        if let accessToken = User.current?.accessToken {
            headers["Authorization"] = "Bearer \(accessToken)"
        }
        
        urlRequest.allHTTPHeaderFields = headers
        
        #if DEBUG
        logRequest(params: params)
        #endif
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .receive(on: DispatchQueue.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                
                #if DEBUG
                self.logResponse(data: data, response: httpResponse)
                #endif
                                
                guard 200...299 ~= httpResponse.statusCode else {
                    
                    guard httpResponse.statusCode != 401 else {
                        throw URLError(.userAuthenticationRequired)
                    }
                    
                    let errorDecoder = JSONDecoder()
                    if let apiError = try? errorDecoder.decode(APIError.self, from: data) {
                        throw apiError
                    } else {
                        throw URLError(.badServerResponse)
                    }
                }
                
                do {
                   let _ = try JSONDecoder().decode(ResponseType.self, from: data)
                } catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
                
                return data
            }
            .decode(type: ResponseType.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func loguot() {
        
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"
    case put = "PUT"
    case patch = "PATCH"
}

extension Dictionary where Key == String, Value == Any? {
    var normalized: [String: Any?] {
        var normalizedDictionary = [String: Any]()
        for (key, value) in self {
            if let _value = value, _value as? String != "" || !(_value is String) {
                normalizedDictionary[key] = _value
            }
        }
        return normalizedDictionary
    }
}

final class APIError: Error, Codable, Hashable {
    var status: String?
    var error: String?
    
    var type: ErrorCode {
        ErrorCode(rawValue: error ?? "") ?? .generic
    }
    
    enum ErrorCode: String, CaseIterable {
        case generic                    = ""
        case expiredToken               = "UNAUTHORIZED"
        case usernameAlreadyRegistered  = "username already registered"
        case emailAlreadyRegistered     = "email already registered"
        case usedTicket                 = "the ticket is used"
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(error)
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
        lhs.error == rhs.error
    }
}

final class GenericResponse: Codable {
    var detail: String?
}

