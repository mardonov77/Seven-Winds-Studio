//
//  AuthManager.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//

import Foundation

final class AuthManager {
    static let shared = AuthManager()
    
    private let userDefaults = UserDefaults.standard
    
    private let isRegisteredKey = "isRegistered"
    private let authTokenKey = "authToken"
    
    func saveToken(_ token: String, lifetime: Int) {
        UserDefaults.standard.set(token, forKey: "authToken")
        let expirationDate = Date().addingTimeInterval(TimeInterval(lifetime))
        UserDefaults.standard.set(expirationDate, forKey: "tokenExpiration")
    }
    
    func getToken() -> String? {
        guard let token = UserDefaults.standard.string(forKey: "authToken"),
              let expiration = UserDefaults.standard.object(forKey: "tokenExpiration") as? Date,
              Date() < expiration else {
            return nil
        }
        return token
    }
    
    var isUserRegistered: Bool {
        return userDefaults.bool(forKey: isRegisteredKey)
    }
    
    var isUserLoggedIn: Bool {
        return userDefaults.string(forKey: authTokenKey) != nil
    }
    
    func setRegistered() {
        userDefaults.set(true, forKey: isRegisteredKey)
    }
    
    func saveAuthToken(_ token: String) {
        userDefaults.set(token, forKey: authTokenKey)
    }
    
    func logout() {
        userDefaults.removeObject(forKey: authTokenKey)
    }
}
