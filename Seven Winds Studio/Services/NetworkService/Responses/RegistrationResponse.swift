//
//  RegistrationResponse.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 07/11/24.
//

import Foundation

struct RegistrationResponse: Codable {
    let token: String
    let tokenLifetime: Int
}
