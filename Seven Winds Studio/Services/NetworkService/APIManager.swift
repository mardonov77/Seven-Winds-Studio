//
//  APIManager.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 02/11/24.
//

import Moya

enum API {
    case register(login: String, password: String)
    case login(login: String, password: String)
    case locations
    case menu(locationId: Int)
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "http://147.78.66.203:3210/")!
    }
    
    var path: String {
        switch self {
        case .register:
            return "auth/register"
        case .login:
            return "auth/login"
        case .locations:
            return "locations"
        case .menu(let locationId):
            return "location/\(locationId)/menu"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .register, .login:
            return .post
        case .locations, .menu:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .register(let login, let password):
            return .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .login(let login, let password):
            return .requestParameters(parameters: ["login": login, "password": password], encoding: JSONEncoding.default)
        case .locations, .menu:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var defaultHeaders = ["Content-type": "application/json"]
        
        if let token = AuthManager.shared.getToken() {
            defaultHeaders["Authorization"] = "Bearer \(token)"
        }
        
        return defaultHeaders
    }
}

final class APIManager {
    static let shared = APIManager()
    let provider: MoyaProvider<API>
    
    init() {
        provider = MoyaProvider<API>()
    }
    
    func request<T: Decodable>(_ target: API, completion: @escaping (Result<T, APIError>) -> Void) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let statusCode = response.statusCode
                    if (200...299).contains(statusCode) {
                        Logger.printResponse(url: URL(target: target), statusCode: statusCode, data: response.data)
                        let decodedData = try JSONDecoder().decode(T.self, from: response.data)
                        completion(.success(decodedData))
                    } else if statusCode == 401 {
                        self.handleTokenExpired()
                    } else {
                        Logger.printResponse(url: target.baseURL, statusCode: statusCode, data: response.data)
                        let errorMessage = String(data: response.data, encoding: .utf8) ?? "Unknown error"
                        completion(.failure(.serverError(statusCode, errorMessage)))
                    }
                } catch {
                    Logger.printDecodingError(error: error)
                    completion(.failure(.decodingError(error.localizedDescription)))
                }
            case .failure(let moyaError):
                Logger.printDecodingError(error: moyaError)
                let errorDescription = moyaError.errorDescription ?? "Unknown network error"
                completion(.failure(.networkError(errorDescription)))
            }
        }
    }

    func handleTokenExpired() {
        AuthManager.shared.logout()
        
        if AuthManager.shared.isUserRegistered {
            AuthManager.shared.setRegistered()
        }
        
        DispatchQueue.main.async {
            if let window = UIApplication.shared.windows.first {
                let loginVC = LoginRouter.createModule()
                window.rootViewController = UINavigationController(rootViewController: loginVC)
                window.makeKeyAndVisible()
            }
        }
    }
}
