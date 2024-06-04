//
//  APIService.swift
//  PokeApp
//
//  Created by Muhammad Adha Fajri Jonison on 02/06/24.
//

import Foundation

enum APIMethod: String {
    case get = "GET"
    case post = "POST"
}

protocol APIService {
    func fetch<T: Decodable>(from url: URL, timeoutInterval: Double?) async throws -> T
    func fetch<T: Decodable>(from url: URL, method: APIMethod, timeoutInterval: Double?) async throws -> T
    func fetch<T: Decodable, U: Encodable>(from url: URL, method: APIMethod, requestBody: U, timeoutInterval: Double?) async throws -> T
}

class APIServiceImpl: APIService {
    func fetch<T: Decodable>(from url: URL, timeoutInterval: Double?) async throws -> T {
        var request = URLRequest(url: url)
        request.timeoutInterval = timeoutInterval ?? 15.0
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetch<T: Decodable>(from url: URL, method: APIMethod, timeoutInterval: Double?) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval ?? 15.0
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    func fetch<T: Decodable, U: Encodable>(from url: URL, method: APIMethod, requestBody: U, timeoutInterval: Double?) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = timeoutInterval ?? 15.0
        
        request.httpBody = try JSONEncoder().encode(requestBody)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}
