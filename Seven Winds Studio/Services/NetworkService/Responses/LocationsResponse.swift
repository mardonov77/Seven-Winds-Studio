//
//  LocationsResponse.swift
//  Seven Winds Studio
//
//  Created by Jam Mardonov on 08/11/24.
//

import Foundation

struct LocationsResponse: Codable {
    let id: Int
    let name: String
    let point: Point
}

// MARK: - Point
struct Point: Codable {
    let latitude: String
    let longitude: String
}

struct MenuResponse: Codable {
    let id: Int
    let imageURL: String
    let name: String
    let price: Int
}
