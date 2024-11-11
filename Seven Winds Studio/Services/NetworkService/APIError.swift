//
//  APIError.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//

import Foundation

enum APIError: Error {
    case networkError(String)
    case serverError(Int, String)
    case decodingError(String)
    case unknownError

    var localizedDescription: String {
        switch self {
        case .networkError(let message):
            return "Network Error: \(message)"
        case .serverError(let statusCode, let message):
            return "Server Error (Code: \(statusCode)): \(message)"
        case .decodingError(let message):
            return "Decoding Error: \(message)"
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}
