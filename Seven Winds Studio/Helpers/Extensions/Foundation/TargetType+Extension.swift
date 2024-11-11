//
//  TargetType+Extension.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//

import Moya

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        switch task {
        case .requestParameters(let parameters, let encoding):
            request = try encoding.encode(request, with: parameters)
        default:
            break
        }
        
        request.allHTTPHeaderFields = headers
        return request
    }
}
